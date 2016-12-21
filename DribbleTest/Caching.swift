//
//  Caching.swift
//  DribbleTest
//
//  Created by Admip on 20.12.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
class Cache {
    
    // MARK: - Caching Shots
    
    static func updateCacheShots(shots: [Shots]) {
 
        let realm = try! Realm()
        try! realm.write({() -> Void in
            realm.deleteAll()
        }
        )
        try! realm.write {
            for sh in shots {
                let cachedShots = ModelShot()
                cachedShots.idShots = sh.idShots
                cachedShots.title = sh.title
                cachedShots.descriptions = sh.descriptions
                cachedShots.imageData = sh.imageData
                cachedShots.imageUrl = sh.imageURL
                cachedShots.userId = sh.userID
                cachedShots.userName = sh.userName
                cachedShots.userAvatarUrl = sh.userAvatarUrl
                cachedShots.likeUserAutho = sh.likeUserAutho
                realm.add(cachedShots)
            }
        }
    }
    
    static func getShots()-> [Shots] {
        
        let realm = try! Realm()
        let allShots = realm.objects(ModelShot)
        var shots = [Shots]()
        for sh in allShots {
            let cachedShot  = Shots()
            cachedShot.idShots = sh.idShots
            cachedShot.title = sh.title
            cachedShot.descriptions = sh.descriptions
            cachedShot.imageData = sh.imageData
            cachedShot.imageURL = sh.imageUrl
            cachedShot.commentsURL = ""
            cachedShot.likeUserAutho = sh.likeUserAutho
            cachedShot.userID = sh.userId
            cachedShot.commentCount = 0
            cachedShot.likesCount = 0
            cachedShot.viewsCount = 0
            cachedShot.userAvatarUrl = sh.userAvatarUrl
            shots.append(cachedShot)
        }
        return shots
    }
    
    // MARK: - Caching Comments
    
    static func updateCacheComments(comments: [Comments], idShot : Int) {
        let realm = try! Realm()
        let cacheShots = ModelShot()
        try! realm.write {
            for cm in comments{
                let cachedComments = ModelComment()
                cachedComments.idShots = idShot
                cachedComments.idComments = cm.id
                cachedComments.body = cm.body
                cachedComments.userId = cm.userId
                cachedComments.userName = cm.userName
                cachedComments.avatarUrl = cm.avatarUrl
                realm.add(cachedComments,update: true)
                cacheShots.commentsShot.append(cachedComments)
            }
            cacheShots.idShots = idShot
            realm.create(ModelShot.self, value: ["idShots": idShot, "commentsShot":  cacheShots.commentsShot], update: true)
        }
        
    }
    
    static func getComments(openIDShot: Int)->[Comments] {
        let realm = try! Realm()
        let allCommentsShot = realm.objects(ModelShot).filter("idShots = \(openIDShot)")
        var comments = [Comments]()
        if allCommentsShot[0].commentsShot != 0 {
            for comment in allCommentsShot[0].commentsShot {
                let cachedComments = Comments()
                cachedComments.idShots = comment.idShots
                cachedComments.id = comment.idComments
                cachedComments.userId = comment.userId
                cachedComments.body = comment.body
                cachedComments.avatarImageNSData = comment.avatarImageNSData
                cachedComments.avatarUrl = comment.avatarUrl
                cachedComments.userName = comment.userName
                comments.append(cachedComments)
            }
        }
        return comments
    }
    
    // MARK: - Caching User
    
    static func updateCasheUser(user: User) {
        let realm = try! Realm()
        try! realm.write {
            let cachedUser = ModelUser()
            cachedUser.idUser =  user.idUser
            cachedUser.authorName = user.authorName
            cachedUser.numberLike = user.numberLike
            cachedUser.numberFollowers = user.numberFollowers
            cachedUser.avatarUrl = user.avatarUrl
            cachedUser.followersURL = user.followersURL
            realm.add(cachedUser, update: true)
        }
    }
    
    static func getUser(idUser: Int)->User {
        
        let realm = try! Realm()
        let userOpen = realm.objects(ModelUser).filter("idUser = \(idUser)")
        let cachedUser = User()
        cachedUser.idUser = userOpen[0].idUser
        cachedUser.authorName = userOpen[0].authorName
        cachedUser.numberLike = userOpen[0].numberLike
        cachedUser.numberFollowers = userOpen[0].numberFollowers
        cachedUser.avatarUrl = userOpen[0].avatarUrl
        cachedUser.followersURL = userOpen[0].followersURL
        return cachedUser
        
    }
    
    // MARK: - Caching Followers
    
    static func updateCasheFollowers(followers: [Follower], id : Int) {
        
        let cacheUser = ModelUser()
        let realm = try! Realm()
        try! realm.write {
            for follower in followers {
                let cachedFollowers = ModelFollower()
                cachedFollowers.idFollowers =  follower.idUser
                cachedFollowers.authorName = follower.authorName
                cachedFollowers.avatarUrl = follower.avatarUrl
                cachedFollowers.numberLike = follower.numberLike
                cachedFollowers.numberFollowers = follower.numberFollowers
                cachedFollowers.likesURL = follower.likesURL
                realm.add(cachedFollowers, update: true)
                cacheUser.folowers.append(cachedFollowers)
            }
            realm.create(ModelUser.self, value: ["idUser": id, "folowers":  cacheUser.folowers], update: true)
        }
    }
    
    static func getFollowers(str: String)->[Follower]{
        let realm = try! Realm()
        let Users = realm.objects(ModelUser).filter("followersURL = '\(str)'")
        var folowers = [Follower]()
        for follower in Users[0].folowers {
            let cachedFollower = Follower()
            cachedFollower.avatarUrl = follower.avatarUrl
            cachedFollower.authorName = follower.authorName
            cachedFollower.idUser = follower.idFollowers
            cachedFollower.numberFollowers = follower.numberFollowers
            cachedFollower.numberLike = follower.numberLike
            cachedFollower.likesURL = follower.likesURL
            folowers.append(cachedFollower)
        }
        return folowers
    }
    
    // MARK: - Caching Likes
    
    static func updateCasheLikes(likes : [Like], id : Int){
        let cacheFollowers = ModelFollower()
        let realm = try! Realm()
        try! realm.write {
            for like in likes {
                let cachedLikes = ModelLikes()
                cachedLikes.idLike =  like.idLike
                cachedLikes.name = like.name
                cachedLikes.avatart_url = like.avatartUrl
                cachedLikes.date = like.date
                cachedLikes.titleShot = like.titleShot
                realm.add(cachedLikes, update: true)
                cacheFollowers.likes.append(cachedLikes)
            }
            realm.create(ModelFollower.self, value: ["idFollowers": id, "likes":  cacheFollowers.likes], update: true)
        }
    }
    
    static func getLikes(str: String)->[Like]{
        let realm = try! Realm()
        let Likes = realm.objects(ModelFollower).filter("likesURL = '\(str)'")
        var likes = [Like]()
        for like_ in Likes[0].likes {
            let cachedLike = Like()
            cachedLike.avatartUrl = like_.avatart_url
            cachedLike.name = like_.name
            cachedLike.date = like_.date
            cachedLike.idLike = like_.idLike
            cachedLike.titleShot = like_.titleShot
            likes.append(cachedLike)
        }
        return likes
    }
}