//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Amzad Chowdhury on 11/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var profilepicView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            
            if tweet.user?.avatarViewURL != nil {
                let avatarImg = URL(string: (tweet.user?.avatarViewURL!)!)
                profilepicView.af_setImage(withURL: avatarImg!)
            }
            // set tweet
            tweetLabel.text = tweet.text
            // set name
            nameLabel.text = tweet.user!.name
            // set tag name
            handleLabel.text = String(format: "@%@", tweet.user!.screenName!)
            // set date
            datetimeLabel.text = tweet.createdAtString
            // set retweet count
            retweetsLabel.text = String(tweet.retweetCount!) + " Retweets"
            // set favoriate count
            favoritesLabel.text = String(format: "%d", tweet.favoriteCount!) + " Favorited"
            
        }
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didReply(_ sender: Any) {
    }
    
    @IBAction func didRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                    self.tweet.retweetCount = tweet.retweetCount! + 1
                    self.retweetsLabel.text = String(format: "%d", tweet.retweetCount!)
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
                    self.retweetsLabel.text = String(format: "%d", tweet.retweetCount!)
                    self.tweet.retweeted = false
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    
    @IBAction func didFavorite(_ sender: Any) {
        if (tweet.favorited == false) {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    self.tweet.favoriteCount = tweet.favoriteCount! + 1
                    self.favoritesLabel.text = String(format: "%d", tweet.favoriteCount!)
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
                    self.favoritesLabel.text = String(format: "%d", tweet.favoriteCount!)
                    self.tweet.favorited = false
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
