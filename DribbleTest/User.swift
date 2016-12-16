//
//  User.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation

class User {
    var idUser: Int!
    var authorName: String!
    var avatarUrl: String!
    var numberLike: Int!
    var numberFollowers: Int!
    var followersURL: String!
    
    
    init(){
        
    }
    
    init(data : NSDictionary){
        self.idUser = data["id"] as! Int
        self.authorName = getStrJSON(data, key: "username")
        self.avatarUrl = getStrJSON(data, key: "avatar_url")
        self.numberLike = data["likes_count"] as! Int
        self.numberFollowers = data["followers_count"] as! Int
        self.followersURL = getStrJSON(data, key: "followers_url")
    }
    
    
    
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}