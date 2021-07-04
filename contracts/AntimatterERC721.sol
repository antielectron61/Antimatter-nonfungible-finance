// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AntimatterERC721 is ERC721, Ownable {
    constructor (string memory name_, string memory symbol_) public ERC721(name_, symbol_) {}

    // tokenid => creator address
    mapping(uint256 => address) public creator;

    function setBaseURI(string memory baseURI_) external onlyOwner {
        super._setBaseURI(baseURI_);
    }

    function mint(address to, uint256 tokenId) external onlyOwner {
        super._safeMint(to, tokenId);
        creator[tokenId] = to;
    }

    function burn(uint256 tokenId) external onlyOwner {
        super._burn(tokenId);
        creator[tokenId] = address(0);
    }

    function batchMint(address to, uint256 fromTokenId, uint256 toTokenId) external onlyOwner {
        for (uint256 tokenId = fromTokenId; tokenId <= toTokenId; tokenId++) {
            super._safeMint(to, tokenId);
            creator[tokenId] = to;
        }
    }
}
