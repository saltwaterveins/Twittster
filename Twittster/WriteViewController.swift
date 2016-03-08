//
//  WriteViewController.swift
//  Twittster
//
//  Created by Stef Epp on 3/7/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profPic: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    @IBOutlet weak var tweetField: UITextView!
    
    var user: User?
    var tweet: Tweet?
    var username: String?
    var actualTweet: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tweetField.delegate = self
        
        tweetField!.layer.borderWidth = 1
        tweetField!.layer.borderColor = UIColor.grayColor().CGColor
        
        usernameLabel.text = "@\(User.currentUser!.screenname)"
        nameLabel.text = "@\(User.currentUser!.name)"
        profPic.setImageWithURL(NSURL(string: (User.currentUser?.profileURL)! as String)!)
        
        tweetField.becomeFirstResponder()
        
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
    
    func typing(textView: UITextView) {
        if  0 < (141 - tweetField.text!.characters.count) {
            tweetButton.enabled = true
            charCount.text = "\(140 - tweetField.text!.characters.count)"
            
        }
        else{
            tweetButton.enabled = false
            charCount.text = "\(140 - tweetField.text!.characters.count)"
            
            
        }
    }
    
    @IBAction func tweetit(sender: AnyObject) {
        actualTweet = tweetField.text
        
        let message = actualTweet.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        TwitterClient.sharedInstance.write(message!, params: nil, completion: { (error) -> () in
                print("composing")
            })
            navigationController?.popViewControllerAnimated(true)
        
    }

}
