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
    
    var dateFormatter = NSDateFormatter()
    
    var tweets: Tweet! {
        didSet {
            tweetText.text = tweets.text as? String
            timeText.text = dateFormatter.stringFromDate(tweets.timeStamp!)
        //}
    //}
    
    
    
    //var users: User!{
        //didSet {
            //let ppURL = NSURL(string: tweets.profileURL)
            //profPic.setImageWithURL(ppURL!)
            nameText.text = tweets.name as? String
            usernameText.text = tweets.screenname as? String
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

}
