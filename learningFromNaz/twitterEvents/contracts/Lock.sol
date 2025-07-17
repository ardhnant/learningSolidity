// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.28; 

//Uncomment this line to use console.log 
//import "hardhat/console.sol"; 

// 1️⃣ Create Event for creating the tweet, called TweetCreated ✅
// USE parameters like id, author, content, timestamp
// 2️⃣ Emit the Event in the createTweet() function below  ✅
// 3️⃣ Create Event for liking the tweet, called TweetLiked ✅ 
// USE parameters like liker, tweetAuthor, tweetId, newLikeCount
// 4️⃣ Emit the event in the likeTweet() function below  ✅

contract Twitter { 
  uint16 public MAX_TWEET_LENGTH = 100;
  
  struct Tweet {
    uint16 id; 
    address author; 
    string content; 
    uint256 timestamp; 
    uint8 likes; 
  } 

  event tweetCreated (uint16 id, address indexed author, string content, uint256 timestamp ); 
  event tweetLiked ( address indexed liker,
                     address indexed tweetAuthor,
                     uint16 tweetId,
                     uint8 newLikeCount);

  mapping ( address => Tweet[] ) public tweets; 
  address public owner; 

  //Define the events here 
  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() { 
   require ( msg.sender == owner, "Oops, you are not the owner." );
   _;
  } 

  function changeTweetLength ( uint16 newTweetLength ) public onlyOwner {
    MAX_TWEET_LENGTH = newTweetLength;
  }

  function createTweet ( string memory _tweet ) public {
    require ( bytes(_tweet).length <= MAX_TWEET_LENGTH, "Oops, Your tweet is too long.");

    Tweet memory newTweet = Tweet({
      id: tweets[msg.sender].length,
      author: msg.sender,
      content: _tweet,
      timestamp: block.timestamp,
      likes: 0 
    });

    tweets[msg.sender].push(newTweet);

    emit tweetCreated ( tweets[msg.sender].length, msg.sender, _tweet, block.timestamp );
  }

  function likeTweet( address author, uint16 id ) public external {
    require ( tweets[author][id].id == id, "Oops, Tweet does not exist." );

    tweets[author][id].likes++;
    emit tweetLiked ( msg.sender, owner, _i, tweets[author][id].likes );

  }

  function unlikeTweet ( address author, uint16 id ) public external {
    require ( tweets[author][id].id == id, "Oops, Tweet does not exist." );
    require ( tweets[author][id].likes >= 0, "Oops, Not enough likes." );

    tweets[author][id].likes--;
    emit tweetLiked ( msg.sender, owner, _i, tweets[author][id].likes );
  }

  function getTweet ( uint16 _i ) public view returns (Tweet memory) {
    return tweets[msg.sender][_i];
  }

  function getAllTweets ( address author) public view returns ( Tweet[] memory ) {
    return tweets[author];
  }
}
