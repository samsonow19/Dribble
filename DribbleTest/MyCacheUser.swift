//
//  MyCacheUser.swift
//  DribbleTest
//
//  Created by Admip on 19.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//


import Foundation
import RealmSwift

class MyCacheUser : Object {

    dynamic var idUser = 0
    dynamic var authorName:String? = nil
    dynamic var avatarUrl: String? = nil
    dynamic var numberLike = 0
    dynamic var numberFollowers = 0
    dynamic var followersURL: String? = nil
    let folowers = List<MyCacheFollowers>()
    
    override static func primaryKey() -> String? {
        return "idUser"
    }
}