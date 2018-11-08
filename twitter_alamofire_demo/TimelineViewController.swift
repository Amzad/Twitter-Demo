//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Amzad Chowdhury on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    var alertController: UIAlertController!
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Tweet] = []
    var isMoreDataLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 103
        tableView.rowHeight = UITableViewAutomaticDimension
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)),
                                 for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        fetchPosts()
    }
    
    @IBAction func logout(_ sender: Any) {
        APIManager.shared.logout()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = posts[indexPath.row]
        return cell
    }
    
    func fetchPosts() {
        APIManager.shared.getHomeTimeLine { (posts, error) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else if let error = error {
                print("Error loading tweets");
            }
        }
    }
    
    @objc func  pullToRefresh(_ refresh: UIRefreshControl) {
        fetchPosts()
        tableView.reloadData()
        refresh.endRefreshing()
    }
    
    @IBAction func on_logOut(_ sender: Any) {
        present(alertController, animated: true)
    }
    
    func loadMoreData() {
        // self.isMoreDataLoading = false
        fetchPosts()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedView" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = self.posts[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.tweet = tweet
            }
        }
    }
}
