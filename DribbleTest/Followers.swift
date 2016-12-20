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
    var avatarUrl: String!
    var numberLike: Int!
    var numberFollowers: Int!
    var likesURL: String!
    var likes = [Like]()
    
    init(){
        
    }
    
    init(data : NSDictionary) {
        self.idUser = data["id"] as! Int
        let follower = data["follower"] as! NSDictionary
        self.authorName = getStrJSON(follower, key: "name")
        self.avatarUrl = getStrJSON(follower, key: "avatar_url")
        self.numberLike = follower["likes_count"] as! Int //???
        self.numberFollowers = follower["followers_count"] as! Int
        self.likesURL = getStrJSON(follower, key: "likes_url")
    }
    
    func getStrJSON(data: NSDictionary, key: String) -> String {
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
}