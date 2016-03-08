//
//  IndividualTweetViewController.swift
//  Twittster
//
//  Created by Stef Epp on 3/7/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class IndividualTweetViewController: UIViewController {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favCounter: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!

    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var timeText: UILabel!
    var tweetID: String = ""
    var tweets: Tweet!
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.user = user
            }) { (error:NSError) -> () in
                //print(error.localizedDescription)
        }
       
        nameLabel.text = "\((tweets.user!.name)!)"
        usernameLabel.text = "@" + "\((tweets.user?.screenname))"
        tweetLabel.text = (tweets.text as! String)
        timeText.text = calculateTimeStamp(tweets.timeStamp!.timeIntervalSinceNow)
        
                
               let imageUrl = tweets.user?.profileURL!
                profPic.setImageWithURL(NSURL(string: imageUrl! as String)!)
                
                tweetID = tweets.id
                retweetLabel.text = String(tweets.retweetCount)
                favCounter.text = String(tweets.favCount)
                
                retweetLabel.text! == "0" ? (retweetLabel.hidden = true) : (retweetLabel.hidden = false)
                favCounter.text! == "0" ? (favCounter.hidden = true) : (favCounter.hidden = false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func OnRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Selected)
            
            if self.retweetLabel.text! > "0" {
                self.retweetLabel.text = String(self.tweets.retweetCount + 1)
            } else {
                self.retweetLabel.hidden = false
                self.retweetLabel.text = String(self.tweets.retweetCount + 1)
            }
        })
    }
    
    @IBAction func OnFav(sender: AnyObject) {
        TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.favButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Selected)
            
            if self.favCounter.text! > "0" {
                self.favCounter.text = String(self.tweets.favCount + 1)
            } else {
                self.favCounter.hidden = false
                self.favCounter.text = String(self.tweets.favCount + 1)
            }
        })
    }
    
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        if (rawTime <= 60) {
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) {
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) {
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) {
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) {
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
        

}
