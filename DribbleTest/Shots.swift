//
//  Shots.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation


class Shots {
    var idShots: Int!
    var title: String!
    var descriptions: String!
    var commentsURL: String!
    var commentCount: Int!
    var likesCount: Int!
    var viewsCount: Int!
    var imageURL: String!
    var imageData : NSData?
    var cache : Int! // 0 - not cashe 1 - cashe 2 - dell 3 - not dell
 
    
    
    init(data : NSDictionary){
        self.idShots = data["id"] as! Int
        self.title = getStrJSON(data, key: "title")
        self.descriptions = getStrJSON(data, key: "description")
        self.commentsURL = getStrJSON(data, key: "comments_url")
        self.commentCount = data["comments_count"] as! Int
        self.likesCount = data["likes_count"] as! Int
        self.viewsCount = data["views_count"] as! Int
        let image = data["images"] as! NSDictionary//{mas}
        self.imageURL = getStrJSON(image, key: "normal")
        self.cache = 0
    }
    



    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}

