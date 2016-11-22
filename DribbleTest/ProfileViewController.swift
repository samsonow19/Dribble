//
//  ProfileViewController.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDataSource, UITableViewDelegate   {
    var count = 0

    @IBOutlet var ImageUser: UIImageView!
    @IBOutlet var LabelNameUser: UILabel!
    @IBOutlet var CountLikes: UILabel!
    @IBOutlet var CountFolowers: UILabel!
    @IBOutlet var tableView: UITableView!
  
    var indexComments = Int()
    var followers = [Follower]()
    var likes = [[Like]]()
    var i = 0
    var openUserID: Int!

    var OpenUser = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        if TestInternetConnection.connectedToNetwork() == true {
            usersGlobal = [User]()
            let api = DriblUser()
            api.loadUsers(didLoadUser, id: openUserID, urlStringParam: "https://api.dribbble.com/v1/users/\(openUserID)?access_token=\(myToken)")
        }
        else {
         
            print(openUserID)
            OpenUser = Cache.GetUser(openUserID)
            
            ImageUser.sd_setImageWithURL(NSURL(string:OpenUser.avatar_url), placeholderImage: UIImage(named: "Placeholder"))            
            
            LabelNameUser.text = OpenUser.authorName
            CountLikes.text = String(OpenUser.numberLike)
            
            CountFolowers.text = String(OpenUser.numberFollowers)
            
            print(OpenUser.followersURL)
            followers = Cache.GetFollowers(OpenUser.followersURL)
            var maslikes = [Like]()
            for fol in followers {
                print(fol.likesURL)
                maslikes = Cache.GetLikes(fol.likesURL)
                likes.append(maslikes)
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
        
    }
   
    func didLoadUser(users_: [User]){
        OpenUser =  users_[0]
        print(OpenUser.followersURL)
        
        ImageUser.sd_setImageWithURL(NSURL(string:OpenUser.avatar_url), placeholderImage: UIImage(named: "Placeholder"))
        LabelNameUser.text = OpenUser.authorName
        CountLikes.text = String(OpenUser.numberLike)
        CountFolowers.text = String(OpenUser.numberFollowers)
        
        Cache.UpdateCasheUser(OpenUser)
        
        let api = DribbleFollowers()
        api.loadFollowers(didLoadFollowers, url: OpenUser.followersURL)
    }
    func didLoadFollowers(folowers_: [Follower]){
        let api = DribbleLikes()
        for follow in folowers_ {
            followers.append(follow)
            api.loadFollowers(didLoadLikes, url: follow.likesURL)
            count++;
        }
        Cache.UpdateCasheFollowers(followers, id: OpenUser.idUser )
        
       
       
    }
    
    func didLoadLikes(likes_: [Like]){
       var maslikes = [Like]()
        for like in likes_ {
            maslikes.append(like)
        }
        likes.append(maslikes )
        Cache.UpdateCasheLikes(maslikes, id: followers[i].idUser)
        i++;
        count--
        if count == 0{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print(indexPath.row)
        LikeGlobal = likes[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell") as! ProfileTableViewCell
  
        print(indexPath.row)
        
        print(String(followers[indexPath.row].numberLike))
        //cell.Likes = likes[indexPath.row]
        
        cell.ImageProfile.sd_setImageWithURL(NSURL(string: followers[indexPath.row].avatar_url), placeholderImage: UIImage(named: "placeHolder"))
        
        print(followers[indexPath.row].authorName)
        cell.Name.text = followers[indexPath.row].authorName
        cell.NumberLikes.text = String(followers[indexPath.row].numberLike)
        
        return cell
    }
    
    
    
    
    
    



}
