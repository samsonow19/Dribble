//
//  LoginViewController.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        if TestInternetConnection.connectedToNetwork() == true {
            OauthDribble.doOAuthDribbble(self)
     
        }
        else {
            Cache.GetShots()
            let ShotsVC = self.storyboard!.instantiateViewControllerWithIdentifier("ShotsVC")
            self.presentViewController(ShotsVC, animated: true, completion: nil)
        }
            

       
        
        if flag == true
        {
            print("Ehuuu")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  

}
