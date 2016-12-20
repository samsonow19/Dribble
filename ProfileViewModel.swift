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
    
    var OpenUser : User!
    var followers = [Follower]()
    var itemFollower = [ItemFollower]()
    var count = 0
    var numberPageFollower = 1
    var urlString: String!
   
    func loadUser(openUserID: Int,completion: (()-> Void)) {
        if TestInternetConnection.connectedToNetwork() == true {
            Alamofire.request(.GET, "https://api.dribbble.com/v1/users/\(openUserID)?access_token=\(myToken)").responseJSON{ respons in
                let JsonResult = respons.2.value
                self.OpenUser = User(data: JsonResult as! NSDictionary)
                self.urlString = self.OpenUser.followersURL+"?page=\(self.numberPageFollower)&access_token=\(myToken)"
                Cache.UpdateCasheUser(self.OpenUser)
                let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()){
                        completion()
                    }}
        }
        } else{
            self.OpenUser = Cache.GetUser(openUserID)
            self.followers = Cache.GetFollowers(OpenUser.followersURL)
            for folower in followers{
                self.itemFollower.append(self.itemForFollower(folower))
            }
            completion()
        }
    }
    
    func returnItemUser()->ItemUser {
        let countLikes = String(OpenUser.numberLike)
        let countFollowers = String(OpenUser.numberFollowers)
        return ItemUser(avatarUrl: OpenUser.avatarUrl, name: OpenUser.authorName, countLikes: countLikes, countFollowers: countFollowers,followersUrl: OpenUser.followersURL)
    }
    
    func LoadFollower(completion: (()-> Void)) {
        
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
                        Cache.UpdateCasheFollowers(self.followers, id: self.OpenUser.idUser)
                        completion()
                    }}
            }
            
        } else{
            completion()
        }
    }
    
    func returnFollower(index : Int)->Follower {
        if (index+1)%12 - 3 == 0 {
            numberPageFollower++
        }
        return followers[index]
    }
    
    func ReturnFollowersCount()->Int {
        return followers.count
    }
    
    func itemForFollower(follower: Follower) -> ItemFollower {
        let item = ItemFollower(imageProfile: follower.avatarUrl, name: follower.authorName, numberLikes: follower.numberLike)
        return item
    }
    
    func retutnItemFollower(id: Int)->ItemFollower {
        return itemFollower[id]
    }
    
}



