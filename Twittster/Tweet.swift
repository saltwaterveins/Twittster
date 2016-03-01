//
//  Tweet.swift
//  Twittster
//
//  Created by Stef Epp on 2/28/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSString?
    var tagline: NSString?
    
    var id: String
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timeStampString)
        }
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
            
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
                profileURL = NSString(string: profileURLString)
        }
            
        tagline = dictionary["description"] as? String
        
        id = String (dictionary["id"]!)
        retweetCount = (dictionary["retweet_count"] as? Int)!
        favCount = (dictionary["favorite_count"] as? Int)!
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
