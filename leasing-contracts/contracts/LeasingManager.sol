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

    ChainLinkDataHolder private chainLinkDataHolder;

    mapping(uint256 => LeasingRigthMetadata) public leasingRigthsMap;
    LeasingRigthMetadata[] private leasingRigths;

    string baseUrl = "https://6422fadc001cb9fc203510d6.mockapi.io/api/v1/users/";

    uint256 leasingIdCache;

    modifier notContractCaller() {
        require(msg.sender.code.length == 0, "LeasingManager: Sender is a contract");
        _;
    }

    modifier onlyLeaseholder(uint256 tokenId) {
        require(msg.sender == leasingRigthsMap[tokenId].leaseholder, "LeasingManager: sender is not the leaseholder");
        _;
    }

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
        leasingRigths.push(leasingRigth);

        return tokenId;
    }

    function lockLeasingRigth(uint256 leasingId) external payable override whenNotPaused notContractCaller {
        LeasingRigthMetadata memory leasingRigth = leasingRigthsMap[leasingId];

        require(leasingRigth.isAvailable, "LeasingManager: rigth is not available");

        leasingIdCache = leasingId;

        string memory url = LeasingMangerUtils.buildUrl(baseUrl, msg.sender);
        bytes32 jobId = chainLinkDataHolder.getJobId();
        requestVolumeData(url, jobId);
    }

    function contribute(uint256 tokenId) external payable whenNotPaused notContractCaller onlyLeaseholder(tokenId) {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];

        leasingRigth.amountPaid += msg.value;
    }

    function yieldLeasingRigth(uint256 tokenId) external whenNotPaused onlyLeaseholder(tokenId) {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[tokenId];

        leasingRigth.isAvailable = true;
    }

    function getLeasingFromSecondaryMarket(uint256 tokenId) external payable whenNotPaused notContractCaller {
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
    }

    function getAllLeasingRigths() external view returns (LeasingRigthMetadata[] memory) {
        return leasingRigths;
    }

    function requestVolumeData(string memory url, bytes32 _jobId) public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfill.selector);

        req.add("get", url);
        req.add("path", "user,capacity");
        req.addInt("times", 1);

        return sendChainlinkRequest(req, chainLinkDataHolder.getFee());
    }

    function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId) {
        _lockLeasingRigth(_volume);
    }

    function _lockLeasingRigth(uint256 userQuota) internal {
        LeasingRigthMetadata storage leasingRigth = leasingRigthsMap[leasingIdCache];

        require(leasingRigth.isAvailable, "LeasingManager: rigth is not available");
        require(userQuota >= leasingRigth.price, "LeasingManager: value sent is less than the price");
        require(msg.value >= leasingRigth.minimumContribution, "LeasingManager: inimum contribution required");

        leasingRigthsMap[1].isAvailable = false;
        leasingRigthsMap[1].leaseholder = msg.sender;
        leasingRigthsMap[1].amountPaid = msg.value;
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainLinkDataHolder.getChainLinkToken());
        require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }
}
