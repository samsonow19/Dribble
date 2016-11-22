//
//  CheckLike.swift
//  DribbleTest
//
//  Created by Admip on 20.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import OAuthSwift

class DriblLikeUser {
    func loadShots(urlStringParam : String)-> Bool {
        
        let urlString = urlStringParam
        //"https://api.dribbble.com/v1/shots/\(id)/like?access_token=\(myToken)"
        let session = NSURLSession.sharedSession()
        let shotsURL = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(shotsURL!) {
            (data,response,error)-> Void in
            
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                do{
                    if let JsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSArray{
                        var likes =  JsonResult[0] as! NSDictionary
                        print(likes)
                        
                      
                        
                        
                    }
                 
                   
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
        }
        return false
       
    }
}
