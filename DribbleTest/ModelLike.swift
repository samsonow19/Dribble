//
//  ModelLike.swift
//  DribbleTest
//
//  Created by Admip on 20.12.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import RealmSwift

class ModelLikes : Object {
    
    dynamic var idLike = 0
    dynamic var name: String? = nil
    dynamic var avatart_url: String? = nil
    dynamic var date: String? = nil
    dynamic var titleShot: String? = nil
    
    override static func primaryKey() -> String? {
        return "idLike"
    }
}