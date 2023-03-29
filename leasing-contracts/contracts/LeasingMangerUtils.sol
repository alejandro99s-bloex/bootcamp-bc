// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";

library LeasingMangerUtils {
    function addressToString(address _address) internal pure returns (string memory) {
        return Strings.toHexString(uint256(uint160(_address)), 20);
    }

    function getSenderSafe(address _sender) internal view returns (address) {
        if (_sender.code.length > 0) revert("LeasingManagerUtils: Sender is a contract");
        return _sender;
    }
}
