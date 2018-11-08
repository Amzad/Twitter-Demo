//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Amzad Chowdhury on 11/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    var tweet: Tweet?
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var characterLabel: UILabel!
    
    func did(post: Tweet) {
        
    }
    

    
    @IBOutlet weak var tweetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
        
        tweetButton.layer.cornerRadius = 5
        let avatarImg = URL(string: (User.current?.avatarViewURL!)!)
        profileView.af_setImage(withURL: avatarImg!)
        nameLabel.text = User.current?.name
        handleLabel.text = User.current?.screenName
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: textField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        // Do the logic you want to happen everytime the textView changes
        // if string is == "do it" etc....
        let currentCount = textField.text!.count
        characterLabel.text = String(currentCount) + "/140"
        
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
