//
//  DribbbleApi.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import OAuthSwift

class DriblShots {
    let accesToken = "3f5b8b149a5a70351e114f3911be7e9910ff3154e0ae9f08061e1064b503e67d"
    
  
    
    func loadShots(completion: (([Shots])-> Void)!) {
        //var urlString = "https://api.dribbble.com/v1/shots?access_token=" + accesToken
        
        var urlString = "https://api.dribbble.com/v1/shots?access_token=" + accesToken
        let session = NSURLSession.sharedSession()
        let shotsURL = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(shotsURL!) {
            (data,response,error)-> Void in
            
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                do{
                    if let JsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSArray{
                        //print(data!)
                        
                        var shots = [Shots]()
                        for shot in JsonResult{
                            let shot = Shots(data: shot as! NSDictionary)
                            shots.append(shot)
                        }
                        
                        
                        let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()){
                                completion(shots)
                            }}
                        
                        

                        
                    }
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
                
                
                
                
            }
        }
        task.resume()
    }
}
