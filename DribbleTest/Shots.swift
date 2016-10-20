//
//  Shots.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation

class Shots{
    var id: Int!
    var imageURL: String!
    var imageData : NSData?
    var userName : String!
    
    
    init(data : NSDictionary){
        self.id = data["id"] as! Int
        self.imageURL = getStrJSON(data, key: "image")
        self.userName = getStrJSON(data, key: "name")
    }
    
    
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}

