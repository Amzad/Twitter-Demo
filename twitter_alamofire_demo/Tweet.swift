//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Amzad Chowdhury on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int?
    var text: String?
    var favoriteCount: Int?
    var favorited: Bool?
    var retweetCount: Int?
    var retweeted: Bool?
    var replyCount: Int?
    var user: User?
    var createdAtString: String?
    
    var retweetedByUser: User?
    
    init(dictionary: [String : Any]) {
        super.init()
        var dictionary = dictionary
        
        // Is this a re-tweet?
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            // Change tweet to original tweet
            dictionary = originalTweet
        }
        
        id = dictionary["id"] as? Int
        text = dictionary["text"] as? String
        replyCount = dictionary["reply_count"] as? Int
        if replyCount == nil {
            replyCount = 999
        }
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String and set the createdAtString property
        createdAtString = formatter.string(from: date)
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
