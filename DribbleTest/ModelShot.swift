//
//  ModelShot.swift
//  DribbleTest
//
//  Created by Admip on 20.12.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import RealmSwift

class ModelShot : Object {
    
    dynamic var idShots = 0
    dynamic var title: String? = nil
    dynamic var descriptions: String? = nil
    dynamic var imageData : NSData?
    dynamic var imageUrl: String? = nil
    dynamic var userId = 0
    dynamic var userName: String? = nil
    dynamic var likeUserAutho: Bool = false
    dynamic var userAvatarUrl: String? = nil
    
    let commentsShot = List<ModelComment>()
    override static func primaryKey() -> String? {
        return "idShots"
    }
    
    
}