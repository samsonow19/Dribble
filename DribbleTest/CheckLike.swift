//
//  CheckLike.swift
//  DribbleTest
//
//  Created by Admip on 20.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire

class DriblLikeUser {
    func loadCheckLike(completion: ((Bool)-> Void), urlStringParam1 : String) {
        
        var flag: Bool!
        Alamofire.request(.GET , urlStringParam1).responseJSON{respons in
            
            
            
            print(respons.2 .value)
            if(respons.2.value != nil)
            {
                flag = true
            }
            else{
                flag = false
            }
            
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    completion(flag)
                }}
        }
        
       
        
       
    }
    func LikeShot(urlStringParam : String)
    {
        print(urlStringParam)
        Alamofire.request(.POST, urlStringParam).responseJSON { respons in
            
            let JsonResult = respons.2.value
            print(respons)
        }

    }
    func DellLikeShot(urlStringParam : String)
    {
        Alamofire.request(.DELETE, urlStringParam)
    }
}
