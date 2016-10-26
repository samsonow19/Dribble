//
//  OauthDribbble.swift
//  DribbleTest
//
//  Created by Admip on 19.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import OAuthSwift



class OauthDribble {
    static func  doOAuthDribbble(this : AnyObject)  {
        /*
        let oauthswift = OAuth2Swift(
            consumerKey:    "e5dfd06e7f32f8093dd689e6146892f376c48207b85df0e8d5662c340c85006e",
            consumerSecret: "9e98a036a8f7ed33c69d196eae551321dd8cf62e7da7b26c736b9bb449b895b8",
            authorizeUrl:   "https://dribbble.com/oauth/authorize",
            accessTokenUrl: "https://dribbble.com/oauth/token",
            responseType:   "code"
        )*/
        
        oauthswift.authorizeWithCallbackURL( NSURL(string: "DribbleTest://oauth-callback/dribbble")!, scope: "", state: "", success: {
            credential, response, parameters in
            
            // Get User
            let parameters =  Dictionary<String, AnyObject>()
            oauthswift.client.get("https://api.dribbble.com/v1/user?access_token=\(credential.oauth_token)", parameters: parameters,
                success: {
                    data, response in
                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    print(jsonDict)
                    flag = true
                    /*
                    let secondVC: ViewController = ViewController()
                    this.presentViewController(secondVC, animated: true, completion: nil)
                 */
                    let ShotsVC = this.storyboard!!.instantiateViewControllerWithIdentifier("ShotsVC")
                    this.presentViewController(ShotsVC, animated: true, completion: nil)
                    
                    
                    
                    
                }, failure: { error in
                    print(error)
                    flag = false
                  
            })
            }, failure: { error in
                print(error.localizedDescription)
                    flag = false
    })
        
    }
}
