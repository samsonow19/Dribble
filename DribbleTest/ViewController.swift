//
//  ViewController.swift
//  DribbleTest
//
//  Created by Admip on 12.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//
import UIKit
import OAuthSwift
import Alamofire


class ViewController: UIViewController {
 
    @IBOutlet var loginbutton: UIButton!
    @IBAction func LoginClick(sender: AnyObject) {
        if TestInternetConnection.connectedToNetwork() == true {
            loginbutton.hidden = true
            OauthDribble.doOAuthDribbble(didLoadDribble)
        } else {
            Cache.GetShots()
            let ShotsVC = self.storyboard!.instantiateViewControllerWithIdentifier("ShotsVC")
            self.presentViewController(ShotsVC, animated: true, completion: nil)
        }
    }
    
    func didLoadDribble() {
        let ShotsVC = self.storyboard!.instantiateViewControllerWithIdentifier("ShotsVC")
        self.presentViewController(ShotsVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}