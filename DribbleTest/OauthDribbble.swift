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
    static func  doOAuthDribbble(completion: (()-> Void) )  {
        oauthswift.authorizeWithCallbackURL( NSURL(string: "DribbleTest://oauth-callback")!, scope: "public+write+comment", state: "", success: {
            credential, response, parameters in
            let parameters =  Dictionary<String, AnyObject>()
            myToken  = credential.oauth_token
            oauthswift.client.get("https://api.dribbble.com/v1/user?access_token=\(credential.oauth_token)", parameters: parameters,
                success: {
                    data, response in
                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    completion()
                }, failure: { error in
                    print(error)
            })
            }, failure: { error in
                print(error.localizedDescription)      
    })
        
    }
}
