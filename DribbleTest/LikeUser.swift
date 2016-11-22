//
//  LikeUser.swift
//  DribbleTest
//
//  Created by Admip on 20.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation

class LikeUser {
    var idLike: Int!
    var like: Bool!
    init(){
    }
    
    init(data : NSDictionary){
        if data["id"] == nil
        {
            self.idLike = data["id"] as! Int
            self.like = true
        }
        else
        {
            self.idLike = data["id"] as! Int
            self.like = false
        }
    }
    
}