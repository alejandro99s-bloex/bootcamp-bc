# FinancialLeasing









## Methods

### createLease

```solidity
function createLease(address _lessee, uint256 _monthlyPayment, uint256 _totalCost, string _name, string _symbol, string _tokenUri) external nonpayable returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _lessee | address | undefined |
| _monthlyPayment | uint256 | undefined |
| _totalCost | uint256 | undefined |
| _name | string | undefined |
| _symbol | string | undefined |
| _tokenUri | string | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getLeaseDetails

```solidity
function getLeaseDetails(uint256 _leaseIndex) external view returns (address, address, uint256, uint256, uint256, bool, string, string, string, address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _leaseIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | address | undefined |
| _2 | uint256 | undefined |
| _3 | uint256 | undefined |
| _4 | uint256 | undefined |
| _5 | bool | undefined |
| _6 | string | undefined |
| _7 | string | undefined |
| _8 | string | undefined |
| _9 | address | undefined |

### getLeasesByLessee

```solidity
function getLeasesByLessee(address _lessee) external view returns (uint256[])
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _lessee | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

### getLeasesByLessor

```solidity
function getLeasesByLessor(address _lessor) external view returns (uint256[])
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _lessor | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

### leases

```solidity
function leases(uint256) external view returns (address lessor, address lessee, uint256 monthlyPayment, uint256 totalCost, uint256 paymentsMade, bool isActive, string name, string symbol, string tokenUri, address leasingRigthAddress)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| lessor | address | undefined |
| lessee | address | undefined |
| monthlyPayment | uint256 | undefined |
| totalCost | uint256 | undefined |
| paymentsMade | uint256 | undefined |
| isActive | bool | undefined |
| name | string | undefined |
| symbol | string | undefined |
| tokenUri | string | undefined |
| leasingRigthAddress | address | undefined |

### lesseeToLeases

```solidity
function lesseeToLeases(address, uint256) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### lessorToLeases

```solidity
function lessorToLeases(address, uint256) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### makePayment

```solidity
function makePayment(uint256 _leaseIndex) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _leaseIndex | uint256 | undefined |



## Events

### LeaseEnded

```solidity
event LeaseEnded(address indexed lessee, uint256 leaseIndex)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| lessee `indexed` | address | undefined |
| leaseIndex  | uint256 | undefined |

### NewLease

```solidity
event NewLease(address indexed lessor, address indexed lessee, uint256 leaseIndex)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| lessor `indexed` | address | undefined |
| lessee `indexed` | address | undefined |
| leaseIndex  | uint256 | undefined |

### PaymentMade

```solidity
event PaymentMade(address indexed lessee, uint256 leaseIndex, uint256 amount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| lessee `indexed` | address | undefined |
| leaseIndex  | uint256 | undefined |
| amount  | uint256 | undefined |



