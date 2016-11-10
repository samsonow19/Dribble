//
//  DribbleComment.swift
//  DribbleTest
//
//  Created by Admip on 26.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
class DriblComments {
   // let accesToken = "3f5b8b149a5a70351e114f3911be7e9910ff3154e0ae9f08061e1064b503e67d"
    func loadShots(completion: (([Comments])-> Void)!, id : Int) {
        print (id)
        let urlString = shots[id].commentsURL + "?access_token=" + myToken
        let session = NSURLSession.sharedSession()
        let commentsURL = NSURL(string: urlString)
        let task = session.dataTaskWithURL(commentsURL!) {
            (data,response,error)-> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                do{
                   let JsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSArray
                        print(JsonResult)
                        var comments = [Comments]()
                        for comment in JsonResult!{
                            
                            let comment = Comments(data: comment as! NSDictionary)
                            comments.append(comment)
                        }
                        let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()){
                                completion(comments)
                            }}
                    
                }catch let error as NSError {
                    print(error.localizedDescription)
                }

            }
        }
        task.resume()
    }
    

}