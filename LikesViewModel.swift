//
//  LikesViewModel.swift
//  DribbleTest
//
//  Created by Admip on 30.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire

class LikeViewModel {
    
    struct ItemLike {
        let avatarUrl: String
        let name: String
        let titleShot: String!
        let date: String
    }
    
    var follower: Follower!
    var carousel: iCarousel!
    var count = 0
    var indexFollower = 0
    var numberPageLike = 1
    var itemLike = [ItemLike]()
    
    func loadFollower(follower : Follower) {
        self.follower = follower
    }
    
    func loadLikes(completion: (()-> Void)) {
        if TestInternetConnection.connectedToNetwork() == true{
        Alamofire.request(.GET, self.follower.likesURL!+"?page=\(self.numberPageLike)&access_token=\(myToken)").responseJSON{ respons in
            self.itemLike = [ItemLike]()
            let jsonResult = respons.2.value as! NSArray!
            if jsonResult != nil {
                for like in jsonResult!{
                    self.follower.likes.append(Like(data: like as! NSDictionary))
                    print(self.follower.likes.last?.name)
                    self.itemLike.append(self.itemForLike(self.follower.likes.last!))
                }
            } else{
                self.follower.likes.append(Like())
            }
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    Cache.updateCasheLikes(self.follower.likes, id: self.follower.idUser)
                    completion()
                }}
            }
        } else{
            self.follower.likes = Cache.getLikes( self.follower.likesURL)
            for like in follower.likes{
                self.itemLike.append(self.itemForLike(like))
            }
            completion()
        }
    }
    func countLike()-> Int {
        return itemLike.count
    }
    
    func itemForLike(like: Like) -> ItemLike {
        let avatarUrl = like.avatartUrl
        let name = like.name
        let titleShot = like.titleShot
        let date = like.date.characters.split{$0 == "T"}.map(String.init)[0]
        let item = ItemLike(avatarUrl: avatarUrl, name: name, titleShot: titleShot, date: date)
        return item
    }
    
    func itemLike(id: Int)-> ItemLike {
        if (id+1)%12 == 0 {
            numberPageLike++
        }
        return itemLike[id]
    }
    
    
}

    
        
