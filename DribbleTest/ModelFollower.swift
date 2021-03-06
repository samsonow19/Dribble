//
//  ModelFollower.swift
//  DribbleTest
//
//  Created by Admip on 20.12.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import RealmSwift

class ModelFollower : Object {
    
    dynamic var idFollowers = 0
    dynamic var authorName: String? = nil
    dynamic var avatarUrl: String? = nil
    dynamic var numberLike = 0
    dynamic var numberFollowers = 0
    dynamic var likesURL: String? = nil
    let likes = List<ModelLikes>()
    
    override static func primaryKey() -> String? {
        return "idFollowers"
    }
}