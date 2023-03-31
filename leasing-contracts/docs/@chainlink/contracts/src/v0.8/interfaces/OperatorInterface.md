# OperatorInterface









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

### distributeFunds

```solidity
function distributeFunds(address payable[] receivers, uint256[] amounts) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| receivers | address payable[] | undefined |
| amounts | uint256[] | undefined |

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

### fulfillOracleRequest2

```solidity
function fulfillOracleRequest2(bytes32 requestId, uint256 payment, address callbackAddress, bytes4 callbackFunctionId, uint256 expiration, bytes data) external nonpayable returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | bytes32 | undefined |
| payment | uint256 | undefined |
| callbackAddress | address | undefined |
| callbackFunctionId | bytes4 | undefined |
| expiration | uint256 | undefined |
| data | bytes | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### getAuthorizedSenders

```solidity
function getAuthorizedSenders() external nonpayable returns (address[])
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address[] | undefined |

### getForwarder

```solidity
function getForwarder() external nonpayable returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

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

### operatorRequest

```solidity
function operatorRequest(address sender, uint256 payment, bytes32 specId, bytes4 callbackFunctionId, uint256 nonce, uint256 dataVersion, bytes data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| sender | address | undefined |
| payment | uint256 | undefined |
| specId | bytes32 | undefined |
| callbackFunctionId | bytes4 | undefined |
| nonce | uint256 | undefined |
| dataVersion | uint256 | undefined |
| data | bytes | undefined |

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

### ownerTransferAndCall

```solidity
function ownerTransferAndCall(address to, uint256 value, bytes data) external nonpayable returns (bool success)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | undefined |
| value | uint256 | undefined |
| data | bytes | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| success | bool | undefined |

### setAuthorizedSenders

```solidity
function setAuthorizedSenders(address[] senders) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| senders | address[] | undefined |

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




