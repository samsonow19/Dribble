//
//  ProfileViewModel.swift
//  DribbleTest
//
//  Created by Admip on 29.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire
class ProfileViewModel {
    
    struct ItemFollower {
        let imageProfile: String
        let name: String
        let numberLikes: Int!
    }
    
    struct ItemUser {
        let avatarUrl: String
        let name: String
        let countLikes: String
        let countFollowers: String
        let followersUrl: String
    }
    
    var openUser : User!
    var followers = [Follower]()
    var itemFollower = [ItemFollower]()
    var count = 0
    var numberPageFollower = 1
    var urlString: String!
   
    func loadUser(openUserID: Int,completion: (()-> Void)) {
        if TestInternetConnection.connectedToNetwork() == true {
            Alamofire.request(.GET, "https://api.dribbble.com/v1/users/\(openUserID)?access_token=\(myToken)").responseJSON{ respons in
                let JsonResult = respons.2.value
                self.openUser = User(data: JsonResult as! NSDictionary)
                self.urlString = self.openUser.followersURL+"?page=\(self.numberPageFollower)&access_token=\(myToken)"
                Cache.updateCasheUser(self.openUser)
                let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()){
                        completion()
                    }}
        }
        } else{
            self.openUser = Cache.getUser(openUserID)
            self.followers = Cache.getFollowers(openUser.followersURL)
            for folower in followers{
                self.itemFollower.append(self.itemForFollower(folower))
            }
            completion()
        }
    }
    
    func itemUser()->ItemUser {
        let countLikes = String(openUser.numberLike)
        let countFollowers = String(openUser.numberFollowers)
        return ItemUser(avatarUrl: openUser.avatarUrl, name: openUser.authorName, countLikes: countLikes, countFollowers: countFollowers,followersUrl: openUser.followersURL)
    }
    
    func loadFollower(completion: (()-> Void)) {
        
        if TestInternetConnection.connectedToNetwork() == true{
            numberPageFollower++
            Alamofire.request(.GET, urlString + "?page=\(self.numberPageFollower)&access_token=\(myToken)").responseJSON{ respons in
                let JsonResult = respons.2.value as! NSArray!
                for folower in JsonResult!{
                    self.followers.append(Follower(data: folower as! NSDictionary))
                    self.itemFollower.append(self.itemForFollower(self.followers.last!))
                }
                let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()){
                        Cache.updateCasheFollowers(self.followers, id: self.openUser.idUser)
                        completion()
                    }}
            }
            
        } else{
            completion()
        }
    }
    
    func follower(index : Int)->Follower {
        if (index+1)%12 - 3 == 0 {
            numberPageFollower++
        }
        return followers[index]
    }
    
    func followersCount()->Int {
        return followers.count
    }
    
    func itemForFollower(follower: Follower) -> ItemFollower {
        let item = ItemFollower(imageProfile: follower.avatarUrl, name: follower.authorName, numberLikes: follower.numberLike)
        return item
    }
    
    func itemFollower(id: Int)->ItemFollower {
        return itemFollower[id]
    }
    
}



