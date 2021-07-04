// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract AntimatterERC1155 is ERC1155, Ownable {
    constructor(string memory uri) ERC1155(uri) public {}

    // tokenid => creator address
    mapping(uint256 => address) public creator;

    function setURI(string memory uri) external onlyOwner {
        super._setURI(uri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data) external onlyOwner {
        super._mint(account, id, amount, data);
        creator[id] = account;
    }

    function burn(address account, uint256 id, uint256 amount) external onlyOwner {
        super._burn(account, id, amount);
        creator[id] = address(0);
    }

    function batchMint(address to, uint256 fromId, uint256 toId, uint256 amount, bytes memory data) external onlyOwner {
        for (uint256 id = fromId; id <= toId; id++) {
            super._mint(to, id, amount, data);
            creator[id] = to;
        }
    }
}
