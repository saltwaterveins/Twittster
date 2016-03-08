//
//  ProfileViewController.swift
//  Twittster
//
//  Created by Stef Epp on 3/7/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let picURL = (user.profileURL!)
        profPic.setImageWithURL(NSURL(string: picURL as String)!)
        
        
        coverImage.setImageWithURL((user.coverURL!))
        
        
       nameLabel.text = user.name as! String
       usernameLabel.text = "@\((user.screenname)!)"
        tweetCount.text = String(user.tweetCount)
        followingCount.text = String(user.followingCount)
        followerCount.text = String(user.followerCount)
        
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

}
