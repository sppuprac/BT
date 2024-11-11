// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    mapping(address => uint256) private balances;

    event Deposited(address indexed customer, uint256 amount);
    event Withdrawn(address indexed customer, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be > 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}