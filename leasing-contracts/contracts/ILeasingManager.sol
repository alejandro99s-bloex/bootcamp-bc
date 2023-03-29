// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

struct LeasingRigthMetadata {
    string tokenUri;
    string name;
    string symbol;
    uint256 price;
    uint256 amountPaid;
    uint256 minimumContribution;
    address leaseholder;
    bool isAvailable;
    address leasingRigthAddress;
}

interface ILeasingManager {
    function addLeasingRigth(
        string memory tokenUri,
        string memory name,
        string memory symbol,
        uint256 price,
        uint256 minimumContribution
    ) external returns (uint256);
    function lockLeasingRigth(uint256 tokenId) external payable;
    function contribute(uint256 tokenId) external payable;
    function yieldLeasingRigth(uint256 tokenId) external;
    function getLeasingFromSecondaryMarket(uint256 tokenId) external payable;
    function claimLeasingRigth(uint256 tokenId) external;
    function pause() external;
    function unpause() external;
}
