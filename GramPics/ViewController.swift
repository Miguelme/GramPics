//
//  ViewController.swift
//  GramPics
//
//  Created by Miguel Fagundez on 11/1/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let FEED_URL = "https://api.instagram.com/v1/users/self/feed?access_token=ACCESS-TOKEN"
    // MARK: Outlets
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var imageIV: UIImageView!
    
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logOutBtn.enabled = false
        self.refreshBtn.enabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Button Pressed Methods
    @IBAction func refreshBtnPressed(sender: AnyObject) {
        
        let sharedStore : NXOAuth2AccountStore = NXOAuth2AccountStore.sharedStore() as! NXOAuth2AccountStore
        let accounts = sharedStore.accountsWithAccountType("Instagram")
        
        if accounts.count == 0 {
            print("No instagram accounts available")
            return
        }
        
        let account: NXOAuth2Account = accounts[0] as! NXOAuth2Account
        let token = account.accessToken.accessToken
        let url = NSURL(string: FEED_URL + "\(token)")
        
        let urlSession = NSURLSession.sharedSession()
        
        
        urlSession.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
        
            // Network Error
            if (error != nil) {
                print("Couldn't finish request because error = \(error)")
                return
            }
            
            // Http Error
            let httpResp : NSHTTPURLResponse = response as! NSHTTPURLResponse
            if httpResp.statusCode < 200 || httpResp.statusCode >= 300 {
                print("Error because status code is \(httpResp.statusCode)")
                return
            }

        
            
            // Parse Error
            do {
                let pkg = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            }catch {
                print("Exception has been thrown")
            }
            
            
        }).resume()
        
        
        
    }
    @IBAction func logOutBtnPressed(sender: AnyObject) {
        let sharedStore : NXOAuth2AccountStore = NXOAuth2AccountStore.sharedStore() as! NXOAuth2AccountStore
        let accounts = sharedStore.accountsWithAccountType("Instagram")
        for account in accounts {
            sharedStore.removeAccount(account as! NXOAuth2Account)
        }
        
        
        self.logInBtn.enabled = true
        self.logOutBtn.enabled = false
        self.refreshBtn.enabled = false
    }
    @IBAction func logInBtnPressed(sender: AnyObject) {
        let sharedStore : NXOAuth2AccountStore = NXOAuth2AccountStore.sharedStore() as! NXOAuth2AccountStore
        sharedStore.requestAccessToAccountWithType("Instagram")
        
        self.logInBtn.enabled = false
        self.logOutBtn.enabled = true
        self.refreshBtn.enabled = true
    }
}

