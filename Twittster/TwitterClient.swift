
//
//  TwitterClient.swift
//  Twittster
//
//  Created by Stef Epp on 2/28/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "8K3NhQWrV9REzuLLHksUBuaOK", consumerSecret: "LrCwVxMblkRtz7cpEuUg9HaKHFxOnKlXFrOwDp9fQBvLz43yu3")
    
    var loginSuccess : (() -> ())?
    var loginFailure : ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twittster://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
    NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({(user:User) -> () in
                User.currentUser = user
                    self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            
            
            self.homeTimeLine({ (tweets:[Tweet]) -> () in
                for tweet in tweets {
                    print(tweet.text)
                }
                }, failure: {(error: NSError) -> () in
                    //print(error.localizedDescription)
            })
            
            //self.currentAccount()
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (tasl:NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    //The following two fuctions
    //are curtsey of @r3dcrosse on gitHub
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Retweeted tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't retweet")
                completion(error: error)
            }
        )
    }
    
    func likeTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Liked tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't like tweet")
                completion(error: error)
            }
        )
    }
    
    

}
