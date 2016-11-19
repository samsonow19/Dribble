//
//  MyCacheComments.swift
//  DribbleTest
//
//  Created by Admip on 10.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
//import Realm
import RealmSwift

class MyCacheComments : Object{
    dynamic var idComments = 0
    dynamic var userId = 0
    dynamic var body: String? = nil
    dynamic var userName: String? = nil
    dynamic var idShots = 0
    dynamic var avatarImageNSData : NSData?
    dynamic var avatarUrl: String? = nil
    
    override static func primaryKey() -> String? {
        return "idComments"
    }
}