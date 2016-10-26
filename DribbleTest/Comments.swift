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
    var body: String!
    var created_at: String!
    var update_at: String!
    var commentCount: Int!
    var userName: String!
    var avatar_url: String!
    init(data : NSDictionary){
        self.id = data["id"] as! Int
        self.body = getStrJSON(data, key: "body")
        self.created_at = getStrJSON(data, key: "created_at")
        self.update_at = getStrJSON(data, key: "updated_at")
        let user = data["user"] as! NSDictionary
        self.userName = getStrJSON(user, key: "name")
        self.avatar_url = getStrJSON(user, key: "avatar_url")
    }
    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
    
}
