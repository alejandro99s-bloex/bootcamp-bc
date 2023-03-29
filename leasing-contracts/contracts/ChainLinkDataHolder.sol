// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract ChainLinkDataHolder is Ownable, ChainlinkClient {
    address private chainLinkTokenAddress;
    address private chainLinkOracleAddress;
    bytes32 private jobId;
    uint256 private fee = (1 * LINK_DIVISIBILITY) / 10;

    /**
     * @notice Initialize the link token and target oracle
     *
     * Polygon Mumbai Testnet details:
     * Link Token: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Oracle: 	0x40193c8518BB267228Fc409a613bDbD8eC5a97b3 (Chainlink DevRel)
     * jobId: ca98366cc7314957b8c012c72f05aeeb
     *
     */
    constructor() {
        chainLinkTokenAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        chainLinkOracleAddress = 0x40193c8518BB267228Fc409a613bDbD8eC5a97b3;
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function getChainLinkToken() external view returns (address) {
        return chainLinkTokenAddress;
    }

    function getChainLinkOracle() external view returns (address) {
        return chainLinkOracleAddress;
    }

    function getJobId() external view returns (bytes32) {
        return jobId;
    }

    function getFee() external view returns (uint256) {
        return fee;
    }

    function setChainLinkToken(address _chainLinkTokenAddress) external onlyOwner {
        chainLinkTokenAddress = _chainLinkTokenAddress;
    }

    function setChainLinkOracle(address _chainLinkOracleAddress) external onlyOwner {
        chainLinkOracleAddress = _chainLinkOracleAddress;
    }

    function setJodId(bytes32 _jobId) external onlyOwner {
        jobId = _jobId;
    }

    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }
}
