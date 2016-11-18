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

    @IBOutlet var tableView: UITableView!
  
    var indexComments = Int()
    var followers = [Follower]()
    var likes = [[Like]]()

    var OpenUser = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        if TestInternetConnection.connectedToNetwork() == true {
            usersGlobal = [User]()
            let api = DriblUser()
            
            api.loadUsers(didLoadUser, id: commentsGlobal[indexComments].userId )
        }
    }
   
    func didLoadUser(users_: [User]){
        OpenUser =  users_[0]
        print(OpenUser.followersURL)
     
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
        
       
       
    }
    
    func didLoadLikes(likes_: [Like]){
       var maslikes = [Like]()
        for like in likes_ {
            maslikes.append(like)
        }
        likes.append(maslikes)
        print(likes)
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
        
        
        
        LikeGlobal = likes[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell") as! ProfileTableViewCell
  
        print(indexPath.row)
        
        print(likes)
        //cell.Likes = likes[indexPath.row]
        
        cell.ImageProfile.sd_setImageWithURL(NSURL(string: followers[indexPath.row].avatar_url), placeholderImage: UIImage(named: "placeHolder"))
        print(followers[indexPath.row].authorName)
        cell.Name.text = followers[indexPath.row].authorName
        cell.NumberLikes.text = followers[indexPath.row].numberLike as? String
        
       
        
        
        
        
     
        
        return cell
    }
    
    
    
    
    
    



}
