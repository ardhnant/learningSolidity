// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter {
    uint16 public maxTweet = 0;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Tweet {
        uint16 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Oops, you are not the owner. Please try again with a different account");
        _;
    }

    function setMaxTweetLength(uint16 _maxTweetLength) public onlyOwner {
        maxTweet = _maxTweetLength;
    }

    function createTweet(string memory _tweet) public onlyOwner {
        require(bytes(_tweet).length <= maxTweet, "Tweet is too long bro!");

        Tweet memory newTweet = Tweet({
            id: uint16(tweets[msg.sender].length),
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function addLike(address author, uint16 id) external {
        require(tweets[author][id].id == id, "Oops, Tweet does not exist.");
        tweets[author][id].likes++;
    }

    function subtractLike(address author, uint16 id) external {
        require(tweets[author][id].id == id, "Oops, Tweet does not exist.");
        require(tweets[author][id].likes > 0, "Oops, Sorry not enough likes.");
        tweets[author][id].likes--;
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
