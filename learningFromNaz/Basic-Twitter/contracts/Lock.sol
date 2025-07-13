// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Twitter {
    mapping(address => string[]) public _tweets;

    function createTweet(string memory _tweet) public {
        _tweets[msg.sender].push(_tweet);
    }

    function getTweet(
        address _owner,
        uint _i
    ) public view returns (string memory) {
        return _tweets[_owner][_i];
    }

    function getAllTweet(address _owner) public view returns (string[] memory) {
        return _tweets[_owner];
    }
}
