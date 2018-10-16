//
//  TweetCell.swift
//  Twitter-Demo
//
//  Created by Amzad Chowdhury on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postUser: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var tweet: Tweet! {
        didSet {
            
            // check for valid profile picture
            if tweet.user?.avatarViewURL != nil {
                let avatarImg = URL(string: (tweet.user?.avatarViewURL!)!)
                avatarView.af_setImage(withURL: avatarImg!)
            }
            // set tweet
            tweetLabel.text = tweet.text
            // set name
            postName.text = tweet.user!.name
            // set tag name
            postUser.text = String(format: "@%@", tweet.user!.screenName!)
            // set date
            dateLabel.text = tweet.createdAtString
            // set retweet count
            retweetLabel.text = String(tweet.retweetCount!)
            // set favoriate count
            favoriteLabel.text = String(format: "%d", tweet.favoriteCount!)
            // set reply count
            replyLabel.text = String(tweet.replyCount!)
            
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if (tweet.favorited == false) {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    self.tweet.favoriteCount = tweet.favoriteCount! + 1
                    self.favoriteLabel.text = String(format: "%d", tweet.favoriteCount!)
                    self.tweet.favorited = true
                }
            }
        } else {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    self.tweet.favoriteCount = tweet.favoriteCount! - 1
                    self.favoriteLabel.text = String(format: "%d", tweet.favoriteCount!)
                    self.tweet.favorited = false
                }
            }
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                    self.tweet.retweetCount = tweet.retweetCount! + 1
                    self.retweetLabel.text = String(format: "%d", tweet.retweetCount!)
                    self.tweet.retweeted = true
                }
            }
        } else {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.tweet.retweetCount = tweet.retweetCount! - 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                    self.retweetLabel.text = String(format: "%d", tweet.retweetCount!)
                    self.tweet.retweeted = false
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }

}
