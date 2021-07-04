// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/cryptography/ECDSA.sol";
import "./AntimatterERC1155.sol";

contract AntimatterERC1155WithSign is AntimatterERC1155 {
    constructor(string memory uri) AntimatterERC1155(uri) public {}

    // address to sign mint message
    address public signer; 
    
    function setSigner(address _signer) external onlyOwner {
        signer = _signer;
    }

    function mintUser(uint256 id, uint256 amount, bytes calldata data, bytes calldata sign, uint expireTime) external {
        require(block.timestamp <= expireTime, "SIGN EXPIRE");
        bytes32 hash = ECDSA.toEthSignedMessageHash(keccak256(abi.encode(msg.sender, id, amount, expireTime)));
        require(ECDSA.recover(hash, sign) == signer, "INVALID SIGNER");
        super._mint(msg.sender, id, amount, data);
        creator[id] = msg.sender;
    }
}