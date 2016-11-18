//  DribbleTest
//
//  Created by Admip on 17.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//
import Foundation

class Like {
    var idLike: Int!
    var name: String!
    var avatart_url: String!
    var date: String!
    var title_shot: String!
    init(){
        
    }
    
    init(data : NSDictionary){
        self.idLike = data["id"] as! Int
        let shot = data["shot"] as! NSDictionary
        let user = shot["user"] as! NSDictionary
        self.name = getStrJSON(user, key: "name")
        self.avatart_url = getStrJSON(user, key: "avatar_url")
        self.date = getStrJSON(data, key: "created_at")
        self.title_shot = getStrJSON(shot, key: "title")
    }
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}