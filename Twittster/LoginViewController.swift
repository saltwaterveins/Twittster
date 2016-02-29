//
//  LoginViewController.swift
//  Twittster
//
//  Created by Stef Epp on 2/22/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    //@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func onLoginClick(sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient.login({ () -> () in
        print("I've logged in")
        self.performSegueWithIdentifier("loginSegue", sender: nil)
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
    }

}
