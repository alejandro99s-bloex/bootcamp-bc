# LeasingManager









## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### PAUSER_ROLE

```solidity
function PAUSER_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### acceptOwnership

```solidity
function acceptOwnership() external nonpayable
```

Allows an ownership transfer to be completed by the recipient.




### addLeasingRigth

```solidity
function addLeasingRigth(string tokenUri, string name, string symbol, uint256 price, uint256 minimumContribution) external nonpayable returns (uint256)
```

Create new leasing rigth and return the id

*Can be called only by the EOA with the DEFAULT_ADMIN_ROLE role*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenUri | string | The token URI of the NFT |
| name | string | The name of the NFT |
| symbol | string | The symbol of the NFT |
| price | uint256 | The price of the leasing rigth |
| minimumContribution | uint256 | The minimum contribution to lock the leasing rigth |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | tokenId The id of the new leasing rigth |

### claimLeasingRigth

```solidity
function claimLeasingRigth(uint256 tokenId) external nonpayable
```



*Allows the current leaseholder of a leasing right to claim ownership of the underlying NFT only when the price is reached.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | uint256 ID of the leasing right to claim. Requirements: The caller must be the current leaseholder of the leasing right. The amount paid must be greater than or equal to the price of the leasing right. Effects: The caller receives ownership of the underlying NFT. If the amount paid exceeds the price of the leasing right, the excess is refunded to the caller. A new instance of the LeasingRigth contract is created, minting a new NFT with the same tokenUri and name as the original leasing right. The new leasing right is assigned to the caller and its address is stored in leasingRigth.leasingRigthAddress. |

### contribute

```solidity
function contribute(uint256 tokenId) external payable
```



*Allows the leaseholder of a token to contribute additional funds to the leasing right paiying until the price is reached.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | The ID of the leasing right token to contribute to. |

### fulfill

```solidity
function fulfill(bytes32 _requestId, uint256 _volume) external nonpayable
```



*Callback function that is called by the Chainlink node to fulfill the volume data request.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _requestId | bytes32 | The ID of the Chainlink request. |
| _volume | uint256 | The volume data returned by the API. |

### getLeasingFromSecondaryMarket

```solidity
function getLeasingFromSecondaryMarket(uint256 tokenId) external payable
```



*Allows a user to acquire a leasing right from the secondary market. The user must provide the ID of the leasing right to acquire and pay the required price. The function will refund any excess payment above the price of the leasing right to the previous leaseholder. The leasing right must be available for acquisition and the amount paid must be equal or greater than the amount paid by the previous leaseholder.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | The ID of the leasing right to acquire. |

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```



*Returns the admin role that controls `role`. See {grantRole} and {revokeRole}. To change a role&#39;s admin, use {_setRoleAdmin}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### grantRole

```solidity
function grantRole(bytes32 role, address account) external nonpayable
```



*Grants `role` to `account`. If `account` had not been already granted `role`, emits a {RoleGranted} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleGranted} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```



*Returns `true` if `account` has been granted `role`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### leasingRigthsMap

```solidity
function leasingRigthsMap(uint256) external view returns (uint256 leasingRigthId, string tokenUri, string name, string symbol, uint256 price, uint256 amountPaid, uint256 minimumContribution, address leaseholder, bool isAvailable, address leasingRigthAddress)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| leasingRigthId | uint256 | undefined |
| tokenUri | string | undefined |
| name | string | undefined |
| symbol | string | undefined |
| price | uint256 | undefined |
| amountPaid | uint256 | undefined |
| minimumContribution | uint256 | undefined |
| leaseholder | address | undefined |
| isAvailable | bool | undefined |
| leasingRigthAddress | address | undefined |

### lockLeasingRigth

```solidity
function lockLeasingRigth(uint256 leasingId) external payable
```

Locks a leasing right identified by `leasingId` and stores relevant data in cache.

*The caller must send a minimum contribution equal to or greater than the `minimumContribution` required by the leasing right.The leasing right must be available for locking, otherwise a `LeasingManager: rigth is not available` error is thrown.Must be called when the contract is not paused.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| leasingId | uint256 | The ID of the leasing right to lock. |

### owner

```solidity
function owner() external view returns (address)
```

Get the current owner




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### pause

```solidity
function pause() external nonpayable
```






### paused

```solidity
function paused() external view returns (bool)
```



*Returns true if the contract is paused, and false otherwise.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from the calling account. Roles are often managed via {grantRole} and {revokeRole}: this function&#39;s purpose is to provide a mechanism for accounts to lose their privileges if they are compromised (such as when a trusted device is misplaced). If the calling account had been revoked `role`, emits a {RoleRevoked} event. Requirements: - the caller must be `account`. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### requestVolumeData

```solidity
function requestVolumeData() external nonpayable returns (bytes32 requestId)
```



*Requests volume data from the Chainlink node and returns the requestId.*


#### Returns

| Name | Type | Description |
|---|---|---|
| requestId | bytes32 | The ID of the Chainlink request. |

### reset

```solidity
function reset() external nonpayable
```






### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from `account`. If `account` had been granted `role`, emits a {RoleRevoked} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### transferOwnership

```solidity
function transferOwnership(address to) external nonpayable
```

Allows an owner to begin transferring ownership to a new address, pending.



#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | undefined |

### unpause

```solidity
function unpause() external nonpayable
```






### withdrawAll

```solidity
function withdrawAll() external nonpayable
```






### withdrawLink

```solidity
function withdrawLink() external nonpayable
```



*Withdraws any remaining LINK tokens from the contract*


### yieldLeasingRigth

```solidity
function yieldLeasingRigth(uint256 tokenId) external nonpayable
```



*Allows the leaseholder of a leasing right to yield it back to the leasing manager, making it available for other users to lease.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | uint256 ID of the leasing right token to be yielded. Requirements: The contract must not be paused. The caller must be the leaseholder of the specified leasing right. Effects: Sets the isAvailable flag of the specified leasing right to true, indicating that it is now available for lease. |



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

### Paused

```solidity
event Paused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### RequestVolume

```solidity
event RequestVolume(bytes32 indexed requestId, uint256 volume)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId `indexed` | bytes32 | undefined |
| volume  | uint256 | undefined |

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| previousAdminRole `indexed` | bytes32 | undefined |
| newAdminRole `indexed` | bytes32 | undefined |

### RoleGranted

```solidity
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### RoleRevoked

```solidity
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### Unpaused

```solidity
event Unpaused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |



