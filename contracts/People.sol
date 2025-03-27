// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract WhiteList {
    mapping (address => bool) public whiteList;
    event Authorized (address _address);

    constructor(){ 
        whiteList[msg.sender] = true;
        emit Authorized(msg.sender);
    }

    modifier check() {
        require (whiteList[msg.sender], "Access denied");
        _;
    }
    
    function authorized(address _address) public check {
        whiteList[_address] = true;
        emit Authorized(_address);
    }
}
