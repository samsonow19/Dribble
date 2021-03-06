//
//  CommentViewModel.swift
//  DribbleTest
//
//  Created by Admip on 29.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire

class CommentViewModel {
    
    struct Item {
        let avatarUrl: String
        let nameAvtor: String
        let body: String
    }
    
    var item = [Item]()
    var comments = [Comments]()
    var tableView: UITableView!
    var storyboard: UIStoryboard!
    var navigationController: UINavigationController!
    var numberPageComments = 1
    var url: String!
    var idShot: Int!
    
    func loadUrl(url: String  ) {
        self.url = url
    }
    func loadIdShot(id: Int) {
        idShot = id
    }
    
    func loadComments(completion: (()-> Void)) {
        
        if TestInternetConnection.connectedToNetwork() == true {
            let urlString = url + "?page=\(numberPageComments)&access_token=\(myToken)"
            Alamofire.request(.GET , urlString).responseJSON{respons in
                let JsonResult = respons.2.value as! NSArray!
                for comment in JsonResult{
                    self.comments.append(Comments(data: comment as! NSDictionary))
                    self.item.append(self.itemForComments(self.comments.last!))
                }
                let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()){
                        print(self.idShot)
                        Cache.updateCacheComments(self.comments, idShot: self.idShot)
                        completion()
                }}
            }
        } else {
            comments = Cache.getComments(idShot)
            for com in comments{
                item.append(itemForComments(com))
            }
            completion()
        }

    }
    
    func commentUserID(id: Int) -> Int {
        return comments[id].userId
    }

    func commentItem(index: Int) -> Item {
        if (index+1)%12 - 3 == 0 {
            if comments.count > 10{
                numberPageComments++
            }
        }
        return item[index]
    }
    
    func ofCountItem()->Int {
        return comments.count
    }
    
    func itemForComments(comment: Comments) -> Item {
        let body = comment.body.stringByReplacingOccurrencesOfString("<[^>]+>",withString: "",  options: .RegularExpressionSearch, range: nil)
        let item = Item(avatarUrl: comment.avatarUrl, nameAvtor: comment.userName, body: body)
        return item
    }
    
    func addComment(text: String,completion: (()-> Void)) {
        Alamofire.request(.POST, url, parameters: ["body" : text , "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    Cache.updateCacheComments(self.comments, idShot: self.idShot)
                    completion()
                }}
        }
    }
  
}

