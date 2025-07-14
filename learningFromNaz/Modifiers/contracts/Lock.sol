// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract PlausibleToken {
    //declaring variables
    address public owner;
    bool public paused;
    mapping(address => uint) public balance;

    //constructor
    constructor() {
        owner = msg.sender;
        paused = false;
        balance[owner] = 1000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Oops, You are not the admin");
        _;
    }

    modifier sufficientBalance() {
        require(!paused, "Cantract is paused");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function transfer(address to, uint amount) public sufficientBalance {
        require(balance[owner] >= amount, "Oops, Insufficient balance");

        balance[msg.sender] -= amount;
        balance[to] += amount;
    }
}
