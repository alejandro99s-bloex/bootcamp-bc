# OracleInterface









## Methods

### fulfillOracleRequest

```solidity
function fulfillOracleRequest(bytes32 requestId, uint256 payment, address callbackAddress, bytes4 callbackFunctionId, uint256 expiration, bytes32 data) external nonpayable returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | bytes32 | undefined |
| payment | uint256 | undefined |
| callbackAddress | address | undefined |
| callbackFunctionId | bytes4 | undefined |
| expiration | uint256 | undefined |
| data | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isAuthorizedSender

```solidity
function isAuthorizedSender(address node) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### withdraw

```solidity
function withdraw(address recipient, uint256 amount) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| recipient | address | undefined |
| amount | uint256 | undefined |

### withdrawable

```solidity
function withdrawable() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |




