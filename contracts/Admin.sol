// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.29;

contract Admin {
    mapping (address => bool) public whitelist;
    mapping (address => bool) public blacklist;

    event Whitelisted(address _address);
    event Blacklisted(address _address);

    constructor(){
        whitelist[msg.sender] = true;
        emit Whitelisted(msg.sender);
    }

    modifier check() {
         require (whitelist[msg.sender], "Access denied");
        _;
    }

    function isWhiteListed () external returns(address) {
        return whitelist
    }
}