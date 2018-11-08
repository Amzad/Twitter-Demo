//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Amzad Chowdhury on 11/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let avatarImg = URL(string: (User.current?.avatarViewURL!)!)
        avatarView.af_setImage(withURL: avatarImg!)
        
        let headerImg = URL(string: (User.current?.bannerURL!)!)
        headerView.af_setImage(withURL: headerImg!)
        
        nameLabel.text = User.current?.name
        handleLabel.text = User.current?.screenName
        taglineLabel.text = User.current?.profileDescription
        
        tweetsLabel.text = String(User.current?.tweetCount ?? 0) + " Tweets"
        followingLabel.text = String(User.current?.followingCount ?? 0) + " Following"
        followersLabel.text = String(User.current?.followersCount ?? 0) + " Followers"
        // Do any additional setup afteroading the view.
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
