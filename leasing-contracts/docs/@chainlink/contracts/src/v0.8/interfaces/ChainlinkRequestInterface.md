# ChainlinkRequestInterface









## Methods

### cancelOracleRequest

```solidity
function cancelOracleRequest(bytes32 requestId, uint256 payment, bytes4 callbackFunctionId, uint256 expiration) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | bytes32 | undefined |
| payment | uint256 | undefined |
| callbackFunctionId | bytes4 | undefined |
| expiration | uint256 | undefined |

### oracleRequest

```solidity
function oracleRequest(address sender, uint256 requestPrice, bytes32 serviceAgreementID, address callbackAddress, bytes4 callbackFunctionId, uint256 nonce, uint256 dataVersion, bytes data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| sender | address | undefined |
| requestPrice | uint256 | undefined |
| serviceAgreementID | bytes32 | undefined |
| callbackAddress | address | undefined |
| callbackFunctionId | bytes4 | undefined |
| nonce | uint256 | undefined |
| dataVersion | uint256 | undefined |
| data | bytes | undefined |




