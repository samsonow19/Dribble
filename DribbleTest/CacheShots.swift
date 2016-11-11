//
//  CacheShots.swift
//  DribbleTest
//
//  Created by Admip on 09.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
class Cache {

    static func UpdateCacheShots(){
        var cacheShots = MyCacheShots()
        let realm = try! Realm()
        var flag : Bool = false
        try! realm.write({() -> Void in
            realm.deleteAll()
        })
       // realm.deleteAll()
        try! realm.write {
            for sh in shots{
                cacheShots = MyCacheShots()
                cacheShots.idShots = sh.idShots
                cacheShots.title = sh.title
                cacheShots.descriptions = sh.descriptions
                cacheShots.imageData = sh.imageData
                realm.add(cacheShots)
            }
        }
        
        let allShots = realm.objects(MyCacheShots)
        /*
        for sh in allShots{
           print("\(sh.title)")
        }*/
        
    }
    
      static func GetShots() {
        let realm = try! Realm()
        let allShots = realm.objects(MyCacheShots)
        var myshots  = Shots()
        shots = [Shots]()
        for sh in allShots {
            myshots = Shots()
            myshots.idShots = sh.idShots
            myshots.title = sh.title
            myshots.descriptions = sh.descriptions
            myshots.imageData = sh.imageData
            myshots.imageURL = ""
            myshots.commentsURL = ""
            myshots.commentCount = 0
            myshots .likesCount = 0
            myshots.viewsCount = 0
            shots.append(myshots)
        }
        /*
        for sh in allShots{
        print("\(sh.title)")
        }*/
    }
    
    // in comments
    
    
    static func UpdateCacheComments(){
        var cacheComments = MyCacheComments()
        let realm = try! Realm()
        let cacheShots = MyCacheShots()
        try! realm.write({() -> Void in
            realm.deleteAll()
        })
        // realm.deleteAll()
        try! realm.write {
            for cm in comments{
              
                cacheComments = MyCacheComments()
                cacheComments.idShots = idShot
                cacheComments.idComments = cm.id
                cacheComments.body = cm.body
                cacheComments.userName = cm.userName
                cacheComments.avatarImageNSData = cm.avatarImageNSData
                realm.add(cacheComments)
                cacheShots.commentsShot.append(cacheComments)
                realm.add(cacheComments, update: true)

            }
        }
        
        
        let allShots = realm.objects(MyCacheShots)


    }
    
    static func GetComments(){
        let realm = try! Realm()
        let allCommentsShot = realm.objects(MyCacheShots)
        var mycomments = Comments()
        comments = [Comments]()
     
        for com in allCommentsShot[idShot].commentsShot {
            mycomments = Comments()
            mycomments.idShots = com.idShots
            mycomments.id = com.idComments
            mycomments.body = com.body
            mycomments.avatarImageNSData = com.avatarImageNSData
            mycomments.avatar_url = ""
            mycomments.userName = com.userName
            comments.append(mycomments)
        }
    }
}

/*  
}
    
    
}
        
        /* // logik
        if allShots.count != 0 {
            let realm = try! Realm()
            let allShots = realm.objects(MyCacheShots)
            
            for allshots in allShots {
                for sh in shots {
                    
                    if sh.idShots == allshots.idShots{
                        flag = true
                        break
                    }
             
                }
                if flag == false {
                    
                    cacheShots.idShots = allshots.idShots
                    cacheShots.title = allshots.title
                    cacheShots.descriptions = allshots.descriptions
                    realm.add(cacheShots)
                    
                }
                
                    
            }
            
        }
        else {
            let realm = try! Realm()
            try! realm.write {
                for sh in shots{
                    
                    
                   //realm.add(sh)
                }
            }
        }
    }
    
    func findh (id : Int) -> Bool {
        for sh in shots {
            if sh.idShots == id{
                return false
            }
        }
        return true
    }
    
    
    
    
    func addUser(){
        let mike = Users()
        mike.name = "Katay"
        let realm = try! Realm()
        try! realm.write {
            realm.add(mike)
        }
        
    }
    func queryShots(){
        let realm = try! Realm()
        let allUsers = realm.objects(Users)
        for person in allUsers{
            print("\(person.name)")
        }
        let test : String = ""
        
    }*/*/
