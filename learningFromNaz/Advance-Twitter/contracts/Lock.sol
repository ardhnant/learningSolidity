// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Twitter {
    //define your struct
    struct Tweet {
        address author;
        string content;
        uint timestamp;
        uint likes;
    }

    uint16 MAX_TWEET_LENGTH = 280;

    //write your code
    mapping(address => Tweet[]) public tweets;

    //creating a function for adding tweets and linking them to the wallet id
    function createTweet(string memory _tweet) public {
        //using require to limit the length of tweets
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Max limit exceded");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        //pushing the tweet
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweet() public view returns (Tweet[] memory) {
        return tweets[msg.sender];
    }
}
