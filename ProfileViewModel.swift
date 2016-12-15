//
//  ProfileViewModel.swift
//  DribbleTest
//
//  Created by Admip on 29.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire
class ProfileViewModel
{
    var OpenUser : User!
    //var likes: [Like]!
    var followers = [Follower]()
    var itemFollower = [ItemFollower]()
    var count = 0
    var numberPageFollower = 1
    var namberPageLikes = 1
    var tableView: UITableView!
    func loadContent(tableView: UITableView!)
    {
        self.tableView = tableView
    }
    func loadModel(openUserID: Int) {
        
        if TestInternetConnection.connectedToNetwork() == true {
            Alamofire.request(.GET, "https://api.dribbble.com/v1/users/\(openUserID)?access_token=\(myToken)").responseJSON{ respons in
                let JsonResult = respons.2.value
                self.OpenUser = User(data: JsonResult as! NSDictionary)
                let urlString = self.OpenUser.followersURL+"?page=\(self.numberPageFollower)&access_token=\(myToken)"
        
                Cache.UpdateCasheUser(self.OpenUser)
                self.LoadFollower(urlString)
                
        }
        }
        else
        {
            self.OpenUser = Cache.GetUser(openUserID)
            self.followers = Cache.GetFollowers(OpenUser.followersURL)
            tableView.reloadData()
        }
    }
    func returnItemUser()->ItemUser
    {
        let countLikes = String(OpenUser.numberLike)
        let countFollowers = String(OpenUser.numberFollowers)
        return ItemUser(avatarUrl: OpenUser.avatar_url, name: OpenUser.authorName, countLikes: countLikes, countFollower: countFollowers)
    }
    
    
    func LoadFollower(urlString : String)
    {
        
        Alamofire.request(.GET, urlString).responseJSON{ respons in
            let JsonResult = respons.2.value as! NSArray!
            for folower in JsonResult!{
                let test = Follower(data: folower as! NSDictionary)
                print (test)
             
                self.followers.append(Follower(data: folower as! NSDictionary))
                
                self.itemFollower.append(self.itemForFollower(self.followers.last!))

            }
            self.tableView.reloadData()
        }
        
        
    }
    func returnFollower(index : Int)->Follower
    {
        return followers[index]
    }

    
    

    
    func ReturnFollowersCount()->Int
    {
        return followers.count
    }
    func itemForFollower(follower: Follower) -> ItemFollower {

        let item = ItemFollower(imageProfile: follower.avatar_url, name: follower.authorName, numberLikes: follower.numberLike)
        
        return item
    }
    func retutnItemFollower(id: Int)->ItemFollower
    {
        if id == followers.count-2
        {
            if followers.count > 10
            {
                numberPageFollower++
                LoadFollower(self.OpenUser.followersURL+"?page=\(self.numberPageFollower)&access_token=\(myToken)")
            }
        }
        print(itemFollower[id].name)
        return itemFollower[id]
    }
    
    
    func returnCell(index: Int )->ProfileTableViewCell
    {
        print(index)
        
        //FollowerGlobal = returnFollower(index)
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell") as! ProfileTableViewCell
   //     cell = tableView.i
        cell.FollowerIcarausel = returnFollower(index)
        
        let item = retutnItemFollower(index)
        print(returnFollower(index).authorName)
       
        
        cell.ImageProfile.sd_setImageWithURL(NSURL(string: item.imageProfile), placeholderImage: UIImage(named: "placeHolder"))

        cell.Name.text = item.name
        cell.NumberLikes.text = String(item.numberLikes)

        return cell
        
    }
    
    
    

    
    struct ItemFollower {
        
        let imageProfile: String
        let name: String
        let numberLikes: Int!
        
    }
    struct ItemUser {
        let avatarUrl: String
        let name: String
        let countLikes: String
        let countFollower: String
        
    }
 
    
    
}



