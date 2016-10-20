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
    
  //  var oauthswift : OAuthSwift?
    var currentParameters = [String: String]()
 
    
    //Del this functions
    func doOAuthDribbble(){
        let oauthswift = OAuth2Swift(
            consumerKey:    "e5dfd06e7f32f8093dd689e6146892f376c48207b85df0e8d5662c340c85006e",
            consumerSecret: "9e98a036a8f7ed33c69d196eae551321dd8cf62e7da7b26c736b9bb449b895b8",
            authorizeUrl:   "https://dribbble.com/oauth/authorize",
            accessTokenUrl: "https://dribbble.com/oauth/token",
            responseType:   "code"
        )
        
        oauthswift.authorizeWithCallbackURL( NSURL(string: "DribbleTest://oauth-callback/dribbble")!, scope: "", state: "", success: {
            credential, response, parameters in
            
            // Get User
            let parameters =  Dictionary<String, AnyObject>()
            oauthswift.client.get("https://api.dribbble.com/v1/user?access_token=\(credential.oauth_token)", parameters: parameters,
                success: {
                    data, response in
                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    print(jsonDict)
                }, failure: { error in
                    print(error)
            })
            }, failure: { error in
                print(error.localizedDescription)
        })
             // var code = credential.oauth_token
            /*
           
            Alamofire.request(.POST, "https://dribbble.com/oauth/token?client_id=e5dfd06e7f32f8093dd689e6146892f376c48207b85df0e8d5662c340c85006e&client_secret=9e98a036a8f7ed33c69d196eae551321dd8cf62e7da7b26c736b9bb449b895b8&code="+code).responseJSON() {
                (_ , data, _) in
                print (data)
                
            }*/

            /*
            
            
            }) { (error) -> Void in
                print(error.localizedDescription)
        }*/
        
        /*
        
        oauthswift.authorizeWithCallbackURL( NSURL(string: "DribbleTest://oauth-callback/dribbble")!, scope: "", state: "", success: {
            credential, response , parameters in
           
            // Get User
            var parameters =  Dictionary<String, AnyObject>()
            var str = credential.oauth_token
            
            oauthswift.client.get("https://api.dribbble.com/v1/user?access_token=\(credential.oauth_token)", parameters: parameters,
                success: {
                    data, response in
                    
                    print("123")
                }, failure: {(error:NSError!) -> Void in
                    print(error)
            })
            }, failure: {(error:NSError!) -> Void in
                print(error.localizedDescription)
        })*/
    }

    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //doOAuthDribbble()
        var test_my = "string"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

