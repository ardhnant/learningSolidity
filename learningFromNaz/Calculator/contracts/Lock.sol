// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Calculator {
    uint result = 0;

    function add(uint num) public {
        result += num;
    }

    function subtract(uint num) public {
        require(num <= result, "Cannot perform the calculus");
        result -= num;
    }

    function multiply(uint num) public {
        result *= num;
    }

    function divide(uint num) public {
        require(num > 0, "Can not do the calculus");
        result /= num;
    }

    function get() public view returns (uint) {
        return result;
    }
}
