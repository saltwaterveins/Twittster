//
//  tweetsViewController.swift
//  Twittster
//
//  Created by Stef Epp on 2/28/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class tweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            //self.users = user
            self.tableView.reloadData()
            
            /*for tweet in tweets {
                    print(tweet.text)
                    //self.tableView.reloadData()
                }*/
                }, failure: {(error: NSError) -> () in
                    //print(error.localizedDescription)
            })
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
                self.user = user
            }) { (error:NSError) -> () in
                //print(error.localizedDescription)
        }
        
        
        //tableView.rowHeight = UITableViewAutomaticDimension

        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        }
        else {
            return 0;
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweets = tweets[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        
        if (segue.identifier == "toIndividTweet") {
            let vc = segue.destinationViewController as! IndividualTweetViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            let tweet = tweets?[indexPath!.row]
            vc.tweets = tweet
            vc.user = User.currentUser
        }
        
        else if (segue.identifier) == "tweetit"{
                let vc = segue.destinationViewController as! WriteViewController
                vc.user = User.currentUser
            
        }
        
        else if (segue.identifier) == "prof"{
            let vc = segue.destinationViewController as! WriteViewController
            vc.user = User.currentUser
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
