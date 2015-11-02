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
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Button Pressed Methods
    @IBAction func refreshBtnPressed(sender: AnyObject) {
    }
    @IBAction func logOutBtnPressed(sender: AnyObject) {
    }
    @IBAction func logInBtnPressed(sender: AnyObject) {
        let sharedStore : NXOAuth2AccountStore = NXOAuth2AccountStore.sharedStore() as! NXOAuth2AccountStore
        sharedStore.requestAccessToAccountWithType("Instagram")
    }
}

