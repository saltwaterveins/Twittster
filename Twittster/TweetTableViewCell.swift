//
//  TweetTableViewCell.swift
//  Twittster
//
//  Created by Stef Epp on 2/29/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var timeText: UILabel!
   
    @IBOutlet weak var RetweetButton: UIButton!
    @IBOutlet weak var FavButton: UIButton!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    var tweetID: String = ""
    
    var dateFormatter = NSDateFormatter()
    
    var tweets: Tweet! {
        didSet {
            
            nameText.text = "\((tweets.user?.name)!)"
            usernameText.text = "@" + "\((tweets.user?.screenname)!)"
            tweetText.text = tweets.text as? String
            timeText.text = "\(tweets.timeStamp!)"
            timeText.text = calculateTimeStamp(tweets.timeStamp!.timeIntervalSinceNow)
            
            
            let imageUrl = tweets.user?.profileURL!
            profPic.setImageWithURL(NSURL(string: imageUrl! as String)!)
            
            tweetID = tweets.id
            retweetCount.text = String(tweets.retweetCount)
            favCount.text = String(tweets.favCount)
            
            retweetCount.text! == "0" ? (retweetCount.hidden = true) : (retweetCount.hidden = false)
            favCount.text! == "0" ? (favCount.hidden = true) : (favCount.hidden = false)
        
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*@IBAction func onTouchFav(sender: UIButton){
        let tweet = tweets[sender.tag]
        if(tweet.favorited){
            tweet.favoritesCount = tweet.favoritesCount - 1
            tweet.favorited = false
        } else{
            TwitterClient.sharedInstance.fav(tweet)
        }
        
        tweetTableView.reloadData()
        
    }*/
    
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
    
    //The two following fuctions are curtsey of @r3dcrosse from gitHub
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        
        TwitterClient.sharedInstance.retweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.RetweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Selected)
            
            if self.retweetCount.text! > "0" {
                self.retweetCount.text = String(self.tweets.retweetCount + 1)
            } else {
                self.retweetCount.hidden = false
                self.retweetCount.text = String(self.tweets.retweetCount + 1)
            }
        })
    }
    
    @IBAction func onLike(sender: AnyObject) {
        
        TwitterClient.sharedInstance.likeTweet(Int(tweetID)!, params: nil, completion: {(error) -> () in
            self.FavButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Selected)
            
            if self.favCount.text! > "0" {
                self.favCount.text = String(self.tweets.favCount + 1)
            } else {
                self.favCount.hidden = false
                self.favCount.text = String(self.tweets.favCount + 1)
            }
        })
    }
    

}
