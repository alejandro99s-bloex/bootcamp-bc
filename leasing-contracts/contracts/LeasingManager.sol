// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "../node_modules/@openzeppelin/contracts/security/Pausable.sol";
import "../node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
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

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => LeasingRigthMetadata) public leasingRigthsMap;

    string baseUrl = "https://64237e6677e7062b3e32e5ef.mockapi.io/users/";

    uint256 leasingIdCache;
    uint256 valueCache;
    address senderCache;
    string urlCache;

    bytes32 private jobId;
    uint256 private fee = (1 * LINK_DIVISIBILITY) / 10;

    event RequestVolume(bytes32 indexed requestId, uint256 volume);

    modifier onlyLeaseholder(uint256 tokenId) {
        if (msg.sender != leasingRigthsMap[tokenId].leaseholder) {
            revert("LeasingManager: sender is not the leaseholder");
        }
        _;
    }

    constructor() ConfirmedOwner(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);

        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0x40193c8518BB267228Fc409a613bDbD8eC5a97b3);
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function addLeasingRigth(
        string memory tokenUri,
        string memory name,
        string memory symbol,
        uint256 price,
        uint256 minimumContribution
    ) external onlyRole(DEFAULT_ADMIN_ROLE) returns (uint256) {
        _tokenIdCounter.increment();

        uint256 tokenId = _tokenIdCounter.current();

        LeasingRigthMetadata memory leasingRigth = LeasingRigthMetadata({
            leasingRigthId: tokenId,
            tokenUri: tokenUri,
            name: name,
            symbol: symbol,
            price: price,
            minimumContribution: minimumContribution,
            amountPaid: 0,
            leaseholder: address(0),
            isAvailable: true,
            leasingRigthAddress: address(0)
        });

        leasingRigthsMap[tokenId] = leasingRigth;

        return tokenId;
    }

    function lockLeasingRigth(uint256 leasingId) external payable override whenNotPaused {
        LeasingRigthMetadata memory leasingRigth = leasingRigthsMap[leasingId];

        require(leasingRigth.isAvailable, "LeasingManager: rigth is not available");
        require(msg.value >= leasingRigth.minimumContribution, "LeasingManager: minimum contribution required");

        leasingIdCache = leasingId;
        valueCache = msg.value;
        senderCache = msg.sender;

        // urlCache = LeasingMangerUtils.buildUrl(baseUrl, msg.sender);
        requestVolumeData();
    }

    function contribute(uint256 tokenId) external payable whenNotPaused onlyLeaseholder(tokenId) {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];

        leasingRigth.amountPaid += msg.value;
    }

    function yieldLeasingRigth(uint256 tokenId) external whenNotPaused onlyLeaseholder(tokenId) {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];

        leasingRigth.isAvailable = true;
    }

    function getLeasingFromSecondaryMarket(uint256 tokenId) external payable whenNotPaused {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];

        require(leasingRigth.isAvailable, "LeasingManager: rigth is not available");
        require(msg.value >= leasingRigth.amountPaid, "LeasingManager: amount paid is less than price");

        uint256 amountToRefund = msg.value - leasingRigth.amountPaid;
        if (amountToRefund > 0) {
            (bool success,) = payable(msg.sender).call{value: amountToRefund}("");
            require(success, "LeasingManager: refund failed");
        }

        leasingRigth.leaseholder = msg.sender;
        leasingRigth.isAvailable = false;
        leasingRigth.amountPaid = msg.value;
    }

    function claimLeasingRigth(uint256 tokenId) external nonReentrant onlyLeaseholder(tokenId) {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];
        require(leasingRigth.amountPaid >= leasingRigth.price, "LeasingManager: amount paid is less than price");

        uint256 amountToRefund = leasingRigth.amountPaid - leasingRigth.price;
        if (amountToRefund > 0) {
            (bool success,) = payable(leasingRigth.leaseholder).call{value: amountToRefund}("");
            require(success, "LeasingManager: refund failed");
        }

        LeasingRigth leasingRigthContract = new LeasingRigth(
            leasingRigth.tokenUri,
            leasingRigth.name
        );
        leasingRigthContract.safeMint(leasingRigth.leaseholder, tokenId, leasingRigth.tokenUri);

        leasingRigth.leasingRigthAddress = address(leasingRigthContract);
    }

    function requestVolumeData() public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

        req.add("get", "https://64237e6677e7062b3e32e5ef.mockapi.io/users/0x3Bd208F4bC181439b0a6aF00C414110b5F9d2656");
        req.add("path", "amount");
        req.addInt("times", 1);

        return sendChainlinkRequest(req, fee);
    }

    uint256 public volume;

    function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId) {
        emit RequestVolume(_requestId, _volume);
        volume = _volume;
        _lockLeasingRigth(_volume, leasingIdCache, valueCache, senderCache);
        leasingIdCache = 0;
        valueCache = 0;
        senderCache = address(0);
    }

    function _lockLeasingRigth(uint256 userQuota, uint256 _leasingId, uint256 _value, address _sender) internal {
        LeasingRigthMetadata memory leasingRigth = leasingRigthsMap[_leasingId];

        require(userQuota >= leasingRigth.price, "LeasingManager: value sent is less than the price");

        leasingRigth.isAvailable = false;
        leasingRigth.leaseholder = _sender;
        leasingRigth.amountPaid += _value;

        leasingRigthsMap[_leasingId] = leasingRigth;
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
