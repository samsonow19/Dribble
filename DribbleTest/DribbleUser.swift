//
//  DribbleUser.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire
class DriblUser {
    // let accesToken = "3f5b8b149a5a70351e114f3911be7e9910ff3154e0ae9f08061e1064b503e67d"
    func loadUsers(completion: (([User])-> Void)!, id : Int) {
      
        let urlString = "https://api.dribbble.com/v1/users/\(id)?access_token=\(myToken)"

        Alamofire.request(.GET, urlString).responseJSON{ respons in 
            //print(respons.2.value)
            let JsonResult = respons.2.value
            var users = [User]()
            let user = User(data: JsonResult as! NSDictionary)
            users.append(user)
            
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    completion(users)
                }}
        }

        /*
        let task = session.dataTaskWithURL(userURL!) {
            (data,response,error)-> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                do{
                    let JsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSArray
                    print(JsonResult)
                    var users = [User]()
                    for user in JsonResult!{
                        
                        let user = User(data: user as! NSDictionary)
                        users.append(user)
                    }
                    let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()){
                            completion(users)
                        }}
                    
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
        }
        task.resume()
    }*/
    
}
}
