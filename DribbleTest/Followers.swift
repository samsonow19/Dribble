//
//  Followers.swift
//  DribbleTest
//
//  Created by Admip on 17.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation


class Follower {
    var idUser: Int!
    var authorName: String!
    var avatar_url: String!
    var numberLike: Int!
    var numberFollowers: Int!
    var likesURL: String!
    var likes = [Like]()
    init(){
        
    }
    
    init(data : NSDictionary){
        self.idUser = data["id"] as! Int
        let follower = data["follower"] as! NSDictionary
        self.authorName = getStrJSON(follower, key: "name")
        self.avatar_url = getStrJSON(follower, key: "avatar_url")
        self.numberLike = follower["likes_count"] as! Int //???
        self.numberFollowers = follower["followers_count"] as! Int
        self.likesURL = getStrJSON(follower, key: "likes_url")
    }
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}