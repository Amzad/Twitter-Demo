//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    private static var _current: User?
    
    var avatarViewURL: String?
    var bannerURL: String?
    var profileDescription: String?
    var followingCount: Int?
    var followersCount: Int?
    var tweetCount: Int?
    var favoritesCount: Int?
    
    // For user persistance
    var dictionary: [String: Any]?
    
    init(dictionary: [String : Any]) {
        super.init()
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        avatarViewURL = dictionary["profile_image_url_https"] as? String
        bannerURL = dictionary["profile_banner_url"] as? String
        profileDescription = dictionary["description"] as? String
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followiers_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        favoritesCount = dictionary["favourites_count"] as? Int
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
        
        
    }
}
