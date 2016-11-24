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
      
        try! realm.write({() -> Void in
            realm.deleteAll()
        })
       // realm.deleteAll()
        try! realm.write {
            for sh in shotsGlobal{
                cacheShots = MyCacheShots()
                cacheShots.idShots = sh.idShots
                cacheShots.title = sh.title
                cacheShots.descriptions = sh.descriptions
                cacheShots.imageData = sh.imageData
                cacheShots.imageUrl = sh.imageURL
                cacheShots.userId = sh.userID
                cacheShots.userName = sh.userName
                cacheShots.userAvatarUrl = sh.userAvatarUrl
                
                cacheShots.likeUserAutho = sh.likeUserAutho
                realm.add(cacheShots)
            }
        }
        
      
        
    }
    
      static func GetShots() {
        let realm = try! Realm()
        let allShots = realm.objects(MyCacheShots)
        var myshots  = Shots()
        shotsGlobal = [Shots]()
        for sh in allShots {
            myshots = Shots()
            myshots.idShots = sh.idShots
            myshots.title = sh.title
            myshots.descriptions = sh.descriptions
            myshots.imageData = sh.imageData
            myshots.imageURL = sh.imageUrl
            myshots.commentsURL = ""
            myshots.likeUserAutho = sh.likeUserAutho
            
            myshots.commentCount = 0
            myshots .likesCount = 0
            myshots.viewsCount = 0
            myshots.userAvatarUrl = sh.userAvatarUrl
            shotsGlobal.append(myshots)
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
        try! realm.write {
            for cm in commentsGlobal{
              
                cacheComments = MyCacheComments()
                cacheComments.idShots = idShot
                cacheComments.idComments = cm.id
                cacheComments.body = cm.body
                cacheComments.userId = cm.userId
                cacheComments.userName = cm.userName
                cacheComments.avatarUrl = cm.avatar_url
                realm.add(cacheComments,update: true)
                cacheShots.commentsShot.append(cacheComments)
            }
            cacheShots.idShots = shotsGlobal[indexShots].idShots
            realm.create(MyCacheShots.self, value: ["idShots": shotsGlobal[indexShots].idShots, "commentsShot":  cacheShots.commentsShot], update: true)
        }

    }
    
    
    
    
    static func GetComments(){
        let realm = try! Realm()
        let allCommentsShot = realm.objects(MyCacheShots).filter("idShots = \(idShot)")
        var mycomments = Comments()
        commentsGlobal = [Comments]()
       
        print(idShot)
        for com in allCommentsShot[0].commentsShot {
            mycomments = Comments()
            mycomments.idShots = com.idShots
            mycomments.id = com.idComments
            mycomments.userId = com.userId
            mycomments.body = com.body
            mycomments.avatarImageNSData = com.avatarImageNSData
            mycomments.avatar_url = com.avatarUrl
            mycomments.userName = com.userName
            commentsGlobal.append(mycomments)
        }
    }
    
    
    
    
    static func UpdateCasheUser(user: User){
        var cacheUser = MyCacheUser()
        let realm = try! Realm()
        try! realm.write {
                cacheUser = MyCacheUser()
                cacheUser.idUser =  user.idUser
                cacheUser.authorName = user.authorName
                cacheUser.numberLike = user.numberLike
                cacheUser.numberFollowers = user.numberFollowers
                cacheUser.avatar_url = user.avatar_url
                cacheUser.followersURL = user.followersURL
                realm.add(cacheUser, update: true)
        }
        
    }
    static func GetUser(idUser: Int)->User{
        
        let realm = try! Realm()
        let userOpen = realm.objects(MyCacheUser).filter("idUser = \(idUser)")
        let myuser = User()
        myuser.idUser = userOpen[0].idUser
        myuser.authorName = userOpen[0].authorName
        myuser.numberLike = userOpen[0].numberLike
        myuser.numberFollowers = userOpen[0].numberFollowers
        myuser.avatar_url = userOpen[0].avatar_url
        myuser.followersURL = userOpen[0].followersURL
        return myuser
        
    }
    
    
    static func UpdateCasheFollowers(followers: [Follower], id : Int){
        var cacheFollowers = MyCacheFollowers()
        let cacheUser = MyCacheUser()
        let realm = try! Realm()
        try! realm.write {
            for follower in followers {
                cacheFollowers = MyCacheFollowers()
                cacheFollowers.idFollowers =  follower.idUser
                cacheFollowers.authorName = follower.authorName
                cacheFollowers.avatar_url = follower.avatar_url
                cacheFollowers.numberLike = follower.numberLike
                cacheFollowers.numberFollowers = follower.numberFollowers
                cacheFollowers.likesURL = follower.likesURL
                
                realm.add(cacheFollowers)
                cacheUser.folowers.append(cacheFollowers)
            }
            
            realm.create(MyCacheUser.self, value: ["idUser": id, "folowers":  cacheUser.folowers], update: true)
        }
        
        
        
    }
    static func GetFollowers(str: String)->[Follower]{
        let realm = try! Realm()
        let Users = realm.objects(MyCacheUser).filter("followersURL = '\(str)'")
        var folowers = [Follower]()
        var f = Follower()
        for fol in Users[0].folowers {
            f = Follower()
            f.avatar_url = fol.avatar_url
            f.authorName = fol.authorName
            f.idUser = fol.idFollowers
            f.numberFollowers = fol.numberFollowers
            f.numberLike = fol.numberLike
            f.likesURL = fol.likesURL
            folowers.append(f)
        }
        return folowers
    }
    
    
    
    
    
    
    
    
    
    
    
    
    static func UpdateCasheLikes(likes : [Like], id : Int){
        var cacheLikes = MyCacheLikes()
        let cacheFollowers = MyCacheFollowers()
        let realm = try! Realm()
        try! realm.write {
            for like in likes {
                cacheLikes = MyCacheLikes()
                cacheLikes.idLike =  like.idLike
                cacheLikes.name = like.name
                cacheLikes.avatart_url = like.avatart_url
                cacheLikes.date = like.date
                cacheLikes.title_shot = like.title_shot
               
                realm.add(cacheLikes)
                cacheFollowers.likes.append(cacheLikes)
            }
            
            realm.create(MyCacheFollowers.self, value: ["idFollowers": id, "likes":  cacheFollowers.likes], update: true)
        }
        
        
        
    }
    static func GetLikes(str: String)->[Like]{
        let realm = try! Realm()
        let Likes = realm.objects(MyCacheFollowers).filter("likesURL = '\(str)'")
        
        var likes = [Like]()
        var l = Like()
       
        
        print(idShot)
        for lik in Likes[0].likes {
            l = Like()
            l.avatart_url = lik.avatart_url
            l.date = lik.date
            l.idLike = lik.idLike
            l.title_shot = lik.title_shot
            likes.append(l)
        }
        return likes
    }
    
    
    
}

