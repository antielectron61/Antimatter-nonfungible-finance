// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./AntimatterERC721.sol";
import "@openzeppelin/contracts/cryptography/ECDSA.sol";

contract AntimatterERC721WithSign is AntimatterERC721 {
    constructor (string memory name_, string memory symbol_) public AntimatterERC721(name_, symbol_) {}

    // address to sign mint message
    address public signer;

    function setSigner(address _signer) external onlyOwner {
        signer = _signer;
    }

    function mintUser(uint256 id, bytes calldata sign, uint expireTime) external {
        require(block.timestamp <= expireTime, "SIGN EXPIRE");
        bytes32 hash = ECDSA.toEthSignedMessageHash(keccak256(abi.encode(msg.sender, id, expireTime)));
        require(ECDSA.recover(hash, sign) == signer, "INVALID SIGNER");
        super._mint(msg.sender, id);
        creator[id] = msg.sender;
    }
}