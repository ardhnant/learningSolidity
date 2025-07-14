// SPDX-License-Identifier: MIT
// 4️⃣ Use onlyOwner on the changeTweetLength function

pragma solidity ^0.8.0;

contract Twitter {
    uint16 maxTweet = 0;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Oops, you are not the owner. Please try again with diffirent account"
        );
        _;
    }

    function createMaxTweetLength(uint16 _maxTweetLength) public {
        maxTweet = _maxTweetLength;
    }

    function createTweet(string memory _tweet) public onlyOwner {
        require(bytes(_tweet).length <= maxTweet, "Tweet is too long bro!");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
