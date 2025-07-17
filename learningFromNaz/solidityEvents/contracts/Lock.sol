// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract solidityEvents{

  event newUserRegistration( address indexed user, string name);

  struct User {
    string username;
    uint8 age;
  }

  mapping( address => User) public users;

  function registerUser( string memory _username, uint8 _age) public {
    User storage newUser = users[msg.sender];
    newUser.username = _username;
    newUser.age = _age;

    emit newUserRegistration( msg.sender, _username );
  }
}
