
//
//  User.swift
//  Twittster
//
//  Created by Stef Epp on 2/28/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSString?
    var tagline: NSString?
    var coverURL: NSURL?
    var tweetCount: Int
    var followerCount: Int
    var followingCount: Int
    var userID: Int
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSString(string: profileURLString)
        }
        
        tagline = dictionary["description"] as? String
        
        userID = dictionary["id"] as! Int
        followerCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
        
        let cover = dictionary["profile_background_image_url_https"] as? String
        if cover != nil {
            coverURL = NSURL(string: cover!)!
        }
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }
            else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            //defaults.setObject(user, forKey: "currentUser")
            
            
            defaults.synchronize()
            
        }
    }
}
