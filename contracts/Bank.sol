// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.29;

contract Bank {
    mapping (address => uint) public balances;

    function deposit(uint amount) payable external{
        balances[msg.sender] += amount;
    }

    function transfert (address recipient, uint amount) payable external {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }
    
    function balanceOf(address account) external view returns(uint){
        return balances[account];
    }
}