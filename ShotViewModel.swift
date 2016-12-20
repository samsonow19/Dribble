//
//  ShotViewModel.swift
//  DribbleTest
//
//  Created by Admip on 25.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire

class ShotViewModel  {
    
    struct Item {
        let title: String
        let description: String
        let imageURL: String!
        let userAvatarUrl: String!
        var imageLike: UIImage!
    }
    
    var item = [Item]()
    var shots = [Shots]()
    var numberShot = 0
    var countItem = 0
    var numberPageShots = 1
    
    func LoadShot(completion: (()-> Void)) {
        if TestInternetConnection.connectedToNetwork() == true {
            let urlString = "https://api.dribbble.com/v1/shots?page=\(numberPageShots)&access_token=\(myToken)"
            Alamofire.request(.GET , urlString).responseJSON{respons in
                let JsonResult = respons.2.value as! NSArray!
                for shot in JsonResult{
                    self.shots.append(Shots(data: shot as! NSDictionary))
                    print(self.shots.last!.idShots)
                    Alamofire.request(.GET , "https://api.dribbble.com/v1/shots/\(self.shots.last!.idShots)/like?access_token=\(myToken)").responseJSON{respons in
                        print(respons.2.value)
                        if (respons.2.value != nil) {
                            self.shots[self.countItem].likeUserAutho = true
                        } else {
                            self.shots[self.countItem].likeUserAutho = false
                        }
                        self.item.append(self.itemForShots(self.shots[self.countItem]))
                        self.countItem++
                        if self.countItem == self.shots.count {
                        let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()){
                                Cache.UpdateCacheShots(self.shots)
                                completion()
                            }}
                        }
                    }
                }
            }
        } else {
            shots = Cache.GetShots()
            for shot in shots {
                item.append(itemForShots(shot))
                self.countItem++
            }
            completion()
        }
    }

    func getIdUser(index: Int)->Int {
        return shots[index].userID
    }
    
    func getIdShot(index: Int)->Int {
        return shots[index].idShots
    }
    
    func getUrlComment(index: Int)->String {
        return shots[index].commentsURL
    }
    
    func Like(index : Int, completion: (()-> Void) ) {
       if shots[index].likeUserAutho == true {
        Alamofire.request(.DELETE, "https://api.dribbble.com/v1/shots/\(shots[index].idShots)/like?access_token=\(myToken)")
            shots[index].likeUserAutho = false
            item[index].imageLike = UIImage(named: "dlike")
            completion()
        } else {
            Alamofire.request(.POST, "https://api.dribbble.com/v1/shots/\(shots[index].idShots)/like?access_token=\(myToken)").responseJSON { respons in
            }
            shots[index].likeUserAutho = true
            item[index].imageLike = UIImage(named: "lheart")
            completion()
        }
        Cache.UpdateCacheShots(shots) 
    }
    
    
    func ofCountItem()->Int {
        return countItem
    }
    
    func retutnItem(index: Int) -> Item {
        if (index+1)%12 - 3 == 0 {
            numberPageShots++
        }
        return item[index]
    }
   
    func itemForShots(shot: Shots) -> Item {
        let title = shot.title
        let description =  shot.descriptions.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        let imageURL = shot.imageURL
        let userAvatarUrl = shot.userAvatarUrl
        let imageLike: UIImage!
        
        if shot.likeUserAutho == true
        {
            imageLike = UIImage(named: "lheart")
        } else {
            imageLike  = UIImage(named: "dlike")
        }
        
        let item = Item(title: title, description: description, imageURL: imageURL!, userAvatarUrl: userAvatarUrl, imageLike: imageLike)
        return item
    }
}

