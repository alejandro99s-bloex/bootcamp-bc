// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import {ERC721} from "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Pausable} from "../node_modules/@openzeppelin/contracts/security/Pausable.sol";
import {Ownable} from "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import {ERC721Burnable} from "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

/// @custom:security-contact fernando@bloex.co
contract LeasingRigth is ERC721, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {
    uint8 public totalSupply = 0;
    uint8 constant MAX_SUPPLY = 1;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to, uint256 tokenId, string memory uri) public onlyOwner {
        require(totalSupply < MAX_SUPPLY, "Max supply reached");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        totalSupply++;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override
        whenNotPaused
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
