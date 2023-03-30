# ChainLinkDataHolder









## Methods

### getChainLinkOracle

```solidity
function getChainLinkOracle() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getChainLinkToken

```solidity
function getChainLinkToken() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getFee

```solidity
function getFee() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getJobId

```solidity
function getJobId() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### setChainLinkOracle

```solidity
function setChainLinkOracle(address _chainLinkOracleAddress) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _chainLinkOracleAddress | address | undefined |

### setChainLinkToken

```solidity
function setChainLinkToken(address _chainLinkTokenAddress) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _chainLinkTokenAddress | address | undefined |

### setFee

```solidity
function setFee(uint256 _fee) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _fee | uint256 | undefined |

### setJodId

```solidity
function setJodId(bytes32 _jobId) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _jobId | bytes32 | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |



## Events

### ChainlinkCancelled

```solidity
event ChainlinkCancelled(bytes32 indexed id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | bytes32 | undefined |

### ChainlinkFulfilled

```solidity
event ChainlinkFulfilled(bytes32 indexed id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | bytes32 | undefined |

### ChainlinkRequested

```solidity
event ChainlinkRequested(bytes32 indexed id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | bytes32 | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |



