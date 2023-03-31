# ConfirmedOwnerWithProposal



> The ConfirmedOwner contract

A contract with helpers for basic contract ownership.



## Methods

### acceptOwnership

```solidity
function acceptOwnership() external nonpayable
```

Allows an ownership transfer to be completed by the recipient.




### owner

```solidity
function owner() external view returns (address)
```

Get the current owner




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### transferOwnership

```solidity
function transferOwnership(address to) external nonpayable
```

Allows an owner to begin transferring ownership to a new address, pending.



#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | undefined |



## Events

### OwnershipTransferRequested

```solidity
event OwnershipTransferRequested(address indexed from, address indexed to)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed from, address indexed to)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |



