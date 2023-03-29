// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "../node_modules/@openzeppelin/contracts/security/Pausable.sol";
import "../node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/Address.sol";
import "../node_modules/@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "../node_modules/@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
//
import "./LeasingRigth.sol";
import "./ILeasingManager.sol";
import "./ChainLinkDataHolder.sol";
import "./LeasingMangerUtils.sol";

/// @custom:security-contact fernando@bloex.co
contract LeasingManager is
    Pausable,
    AccessControl,
    ILeasingManager,
    ChainlinkClient,
    ConfirmedOwner,
    ReentrancyGuard
{
    using Counters for Counters.Counter;
    using Chainlink for Chainlink.Request;

    Counters.Counter private _tokenIdCounter;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    ChainLinkDataHolder private chainLinkDataHolder;

    mapping(uint256 => LeasingRigthMetadata) public leasingRigthsMap;
    mapping(address => uint256) public leasingRigthsByOwner;
    LeasingRigthMetadata[] private leasingRigths;

    LeasingRigthMetadata private leasingRigthCache;

    event RequestVolume(bytes32 indexed requestId, uint256 volume);
    event LeasingRigthLocked(uint256 indexed leasingId, address indexed owner);
    event LeasingCreated(uint256 indexed leasingId);
    event ContributionAdded(uint256 indexed leasingId, uint256 amount);
    event LeasingClaimed(uint256 indexed leasingId, address indexed owner);

    constructor() ConfirmedOwner(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);

        chainLinkDataHolder = new ChainLinkDataHolder();
    }

    function addLeasingRigth(
        string memory tokenUri,
        string memory name,
        string memory symbol,
        uint256 price,
        uint256 minimumContribution
    ) external onlyRole(DEFAULT_ADMIN_ROLE) returns (uint256) {
        uint256 leasingId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        LeasingRigthMetadata memory leasingRigth = LeasingRigthMetadata({
            tokenUri: tokenUri,
            name: name,
            symbol: symbol,
            price: price,
            amountPaid: 0,
            minimumContribution: minimumContribution,
            leaseholder: address(0),
            isAvailable: true,
            leasingRigthAddress: address(0)
        });

        leasingRigthsMap[leasingId] = leasingRigth;
        leasingRigths.push(leasingRigth);

        return leasingId;
    }

    function lockLeasingRigth(uint256 leasingId) external payable override whenNotPaused {
        address sender = LeasingMangerUtils.getSenderSafe(msg.sender);

        leasingRigthCache = leasingRigthsMap[leasingId];
        if (leasingRigthCache.leaseholder != address(0)) revert("LeasingManager: leasing rigth is already locked");
        if (!leasingRigthCache.isAvailable) revert("LeasingManager: leasing rigth is not available");
        if (msg.value < leasingRigthCache.minimumContribution) {
            revert("LeasingManager: minimum contribution is required");
        }

        leasingRigthCache.leaseholder = sender;
        leasingRigthCache.amountPaid = msg.value;

        requestVolumeData(LeasingMangerUtils.addressToString(sender), chainLinkDataHolder.jobId());
    }

    function _lockLeasingRigth(uint256 userQuota) internal {
        if (userQuota == 0) revert("LeasingManager: userQuota is not set");
        if (userQuota >= leasingRigthCache.price) revert("LeasingManager: userQuota is not enough");

        leasingRigthCache.isAvailable = false;
    }

    function contribute(uint256 tokenId) external payable whenNotPaused {
        address sender = LeasingMangerUtils.getSenderSafe(msg.sender);

        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];
        if (leasingRigth.leaseholder != sender) revert("LeasingManager: sender is not the owner");
        if (leasingRigth.isAvailable) revert("LeasingManager: leasing rigth is available");

        leasingRigth.amountPaid += msg.value;
        emit ContributionAdded(tokenId, msg.value);
    }

    function yieldLeasingRigth(uint256 tokenId) external whenNotPaused {
        address sender = LeasingMangerUtils.getSenderSafe(msg.sender);

        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];
        if (leasingRigth.leaseholder != sender) revert("LeasingManager: sender is not the owner");
        if (leasingRigth.isAvailable) revert("LeasingManager: leasing rigth is available");

        leasingRigth.isAvailable = true;
    }

    function getLeasingFromSecondaryMarket(uint256 tokenId) external payable whenNotPaused {
        address sender = LeasingMangerUtils.getSenderSafe(msg.sender);

        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];
        if (leasingRigth.leaseholder == sender) revert("LeasingManager: sender is the owner");
        if (leasingRigth.leaseholder == address(0)) {
            revert("LeasingManager: leasing rigth is not available in secondary market");
        }
        if (msg.value < leasingRigth.amountPaid) {
            revert("LeasingManager: amount paid is not enough");
        }

        if (msg.value > leasingRigth.amountPaid) {
            (bool success,) = payable(sender).call{value: leasingRigth.amountPaid}("");
            require(success, "LeasingManager: transfer failed");

            leasingRigth.amountPaid = msg.value;
        }

        leasingRigth.isAvailable = true;
    }

    function claimLeasingRigth(uint256 tokenId) external nonReentrant {
        address sender = LeasingMangerUtils.getSenderSafe(msg.sender);

        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];
        if (leasingRigth.leaseholder != sender) revert("LeasingManager: sender is not the owner");
        if (leasingRigth.amountPaid < leasingRigth.price) revert("LeasingManager: amount paid is not enough");

        if (leasingRigth.amountPaid > leasingRigth.price) {
            (bool success,) = payable(sender).call{value: leasingRigth.amountPaid - leasingRigth.price}("");
            require(success, "LeasingManager: transfer failed");
        }

        LeasingRigth leasingRigthContract = new LeasingRigth(
            leasingRigth.name,
            leasingRigth.symbol
        );
        leasingRigthContract.safeMint(sender, tokenId, leasingRigth.tokenUri);

        leasingRigth.leasingRigthAddress = address(leasingRigthContract);
        leasingRigthsByOwner[sender] = tokenId;

        emit LeasingClaimed(tokenId, sender);
    }

    function requestVolumeData(string memory _userAddress, bytes32 _jobId) public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfill.selector);

        string memory endpoint =
            string.concat("https://6422fadc001cb9fc203510d6.mockapi.io/api/v1/users/", _userAddress);

        req.add("get", endpoint);
        req.add("path", "amount");
        req.addInt("times", 1);

        return sendChainlinkRequest(req, chainLinkDataHolder.fee());
    }

    function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId) {
        emit RequestVolume(_requestId, _volume);
        _lockLeasingRigth(_volume);
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }
}
