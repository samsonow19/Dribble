//
//  CommentViewModel.swift
//  DribbleTest
//
//  Created by Admip on 29.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import Alamofire

class CommentViewModel  {
    var item = [Item]()
    var comments = [Comments]()
    
    var tableView: UITableView!
    var storyboard: UIStoryboard!
    var navigationController: UINavigationController!
    var numberPageComments = 1
    var url: String!
    var IdShot: Int!
    
    func LoadComponent(url: String ,Idshot: Int, tableView: UITableView, storyboard: UIStoryboard, navigationController: UINavigationController  )
    {
        self.url = url
        self.IdShot = Idshot
        self.tableView = tableView
        self.storyboard = storyboard
        self.navigationController = navigationController
        
    }
    
    func LoadComments()
    {
        
        if TestInternetConnection.connectedToNetwork() == true {
            
            let urlString = url + "?page=\(numberPageComments)&access_token=\(myToken)"
            Alamofire.request(.GET , urlString).responseJSON{respons in
                let JsonResult = respons.2.value as! NSArray!
                
                for comment in JsonResult{
                    self.comments.append(Comments(data: comment as! NSDictionary))
                    self.item.append(self.itemForComments(self.comments[self.comments.count-1]))
                }

                Cache.UpdateCacheComments(self.comments, idShot: self.IdShot)
                
                
                self.tableView.reloadData()
                
            }
        }
        else {
            comments = Cache.GetComments(IdShot)
            for com in comments
            {
                item.append(itemForComments(com))
            }
            tableView.reloadData()
        }
    }
    
    func returnCell(  index: Int , target: AnyObject)-> CommentsTableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentsTableViewCell") as! CommentsTableViewCell
        
        let item = retutnItem(index)
        
    
        cell.CommentImage.sd_setImageWithURL(NSURL(string: item.avatar_url), placeholderImage: UIImage(named: "Placeholder"))
        cell.CommentLabel.text = item.body
        cell.NameAvtorLabel.text = item.name_avtor
        
        
        
        cell.CommentImage.userInteractionEnabled = true
        
        let tapRecog = UITapGestureRecognizer(target: target, action: "imgTap:")
        
        cell.CommentImage.addGestureRecognizer(tapRecog)

        
        return cell
        
    }
   
    
    
    func retutnItem(id: Int) -> Item
    {
       
        if id == comments.count-2
        {
            if comments.count > 10
            {
                numberPageComments++
                LoadComments()
            }
        }
        
        return item[id]
        
    }
    func ofCountItem()->Int
    {
        print(comments.count)
       
        return comments.count
    
        
    }
    
    func itemForComments(comment: Comments) -> Item {
        
       let body = comment.body.stringByReplacingOccurrencesOfString("<[^>]+>",withString: "",  options: .RegularExpressionSearch, range: nil)
        
        let item = Item(avatar_url: comment.avatar_url, name_avtor: comment.userName, body: body)
        
        return item
    }
    func AddComment(text: String)
    {
        
        Alamofire.request(.POST, url, parameters: ["body" : text , "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
            print(respons)
            
            
            self.LoadComments()
            self.tableView.reloadData()

        }
    }
    func GoToProfileController(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
    
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
      
        profileViewController.openUserID = comments[indexPath.row].userId
        
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }

    
    struct Item {
       
        let avatar_url: String
        let name_avtor: String
        let body: String

    }
}

