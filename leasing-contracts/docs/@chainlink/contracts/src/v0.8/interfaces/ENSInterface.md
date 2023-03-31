# ENSInterface









## Methods

### owner

```solidity
function owner(bytes32 node) external view returns (address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### resolver

```solidity
function resolver(bytes32 node) external view returns (address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### setOwner

```solidity
function setOwner(bytes32 node, address owner) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |
| owner | address | undefined |

### setResolver

```solidity
function setResolver(bytes32 node, address resolver) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |
| resolver | address | undefined |

### setSubnodeOwner

```solidity
function setSubnodeOwner(bytes32 node, bytes32 label, address owner) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |
| label | bytes32 | undefined |
| owner | address | undefined |

### setTTL

```solidity
function setTTL(bytes32 node, uint64 ttl) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |
| ttl | uint64 | undefined |

### ttl

```solidity
function ttl(bytes32 node) external view returns (uint64)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined |



## Events

### NewOwner

```solidity
event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node `indexed` | bytes32 | undefined |
| label `indexed` | bytes32 | undefined |
| owner  | address | undefined |

### NewResolver

```solidity
event NewResolver(bytes32 indexed node, address resolver)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node `indexed` | bytes32 | undefined |
| resolver  | address | undefined |

### NewTTL

```solidity
event NewTTL(bytes32 indexed node, uint64 ttl)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node `indexed` | bytes32 | undefined |
| ttl  | uint64 | undefined |

### Transfer

```solidity
event Transfer(bytes32 indexed node, address owner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| node `indexed` | bytes32 | undefined |
| owner  | address | undefined |



