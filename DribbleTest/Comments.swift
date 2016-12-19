//
//  Comments.swift
//  DribbleTest
//
//  Created by Admip on 26.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
class Comments {
    var id: Int!
    var idShots: Int?
    var body: String!
    var createdAt: String!
    var updateAt: String!
    var commentCount: Int!
    var userName: String!
    var userId: Int!
    var avatarUrl: String!
    var avatarImageNSData : NSData?
    init(){
        
    }
    
    init(data : NSDictionary){
        self.id = data["id"] as! Int
        self.body = getStrJSON(data, key: "body")
        self.createdAt = getStrJSON(data, key: "created_at")
        self.updateAt = getStrJSON(data, key: "updated_at")
        let user = data["user"] as! NSDictionary
        self.userName = getStrJSON(user, key: "name")
        self.userId = user["id"] as! Int
        self.avatarUrl = getStrJSON(user, key: "avatar_url")
    }
    func getStrJSON(data: NSDictionary, key: String) -> String {
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
    }
}
