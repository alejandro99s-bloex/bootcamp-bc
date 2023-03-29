// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract ChainLinkDataHolder is Ownable, ChainlinkClient {
    address public chainLinkToken;
    address public chainLinkOracle;
    bytes32 public jobId;
    uint256 public fee = (1 * LINK_DIVISIBILITY) / 10;

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
        chainLinkToken = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        chainLinkOracle = 0x40193c8518BB267228Fc409a613bDbD8eC5a97b3;
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function setChainLinkToken(address _chainLinkToken) external onlyOwner {
        chainLinkToken = _chainLinkToken;
    }

    function setChainLinkOracle(address _chainLinkOracle) external onlyOwner {
        chainLinkOracle = _chainLinkOracle;
    }

    function setJodId(bytes32 _jobId) external onlyOwner {
        jobId = _jobId;
    }

    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }
}
