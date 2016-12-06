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
    
    var item = [Item]()
    var shots = [Shots]()
    var tableView: UITableView!
    var storyboard: UIStoryboard!
    var navigationController: UINavigationController!
    var numberShot = 0
    var countItem = 0
    var numberPageShots = 1
  
    func LoadShot(tableView: UITableView, storyboard: UIStoryboard, navigationController: UINavigationController  )
    {
        self.tableView = tableView
        self.storyboard = storyboard
        self.navigationController = navigationController
        if TestInternetConnection.connectedToNetwork() == true {

            let urlString = "https://api.dribbble.com/v1/shots?page=\(numberPageShots)&access_token=\(myToken)"
            Alamofire.request(.GET , urlString).responseJSON{respons in
                let JsonResult = respons.2.value as! NSArray!
                
                for shot in JsonResult{
                    self.shots.append(Shots(data: shot as! NSDictionary))
                    Alamofire.request(.GET , "https://api.dribbble.com/v1/shots/\(self.shots[self.shots.count-1].idShots)/like?access_token=\(myToken)").responseJSON{respons in
                        if(respons.2.value != nil)
                        {
                            self.shots[self.countItem].likeUserAutho = true

                        }
                        else{
                            
                            self.shots[self.countItem].likeUserAutho = false
                        }
                        self.item.append(self.itemForShots(self.shots[self.countItem]))
                        self.countItem++
                      
                        if self.countItem == self.shots.count
                        {
                            Cache.UpdateCacheShots(self.shots)
                            tableView.reloadData()
                        }
                    }
            }
       
            }
        }
        else {
            shots = Cache.GetShots();
        }
     
    }
    func returnCell(cell:ShotsTableViewCell,  index: Int , tableView: UITableView, target: AnyObject)-> ShotsTableViewCell
    {
        
        let item = retutnItem(index, tableView: tableView)
        
        
        print(item)
        cell.ImageShot.sd_setImageWithURL(NSURL(string: item.imageURL), placeholderImage: UIImage(named: "placeHolder"))
        
        cell.TitleShot.text = item.title
        
        cell.DescriptionShot.text = item.description
        
        
        cell.ImageShotAvtor.sd_setImageWithURL(NSURL(string: item.userAvatarUrl), placeholderImage: UIImage(named: "placeHolder"))
        
        cell.ImageShotLike.image = item.imageLike
        
        cell.ImageShotAvtor.userInteractionEnabled = true
        
        let tapRecog = UITapGestureRecognizer(target: target, action: "imgTappUser:")
        
        cell.ImageShotAvtor.addGestureRecognizer(tapRecog)
        
        cell.ImageShotLike.userInteractionEnabled = true

        
        let tapRecoglike = UITapGestureRecognizer(target: target, action: "imgTappLike:")
        
        cell.ImageShotLike.addGestureRecognizer(tapRecoglike)
        
        
        
        return cell
        
    }
    func getIdUser(index: Int)->Int
    {
        return shots[index].userID
    }
    func getIdShot(index: Int)->Int{
        return shots[index].idShots
    }
    
    
    func getUrlComment(index: Int)->String
    {
        return shots[index].commentsURL
    }
    
    
    func Like(index : Int, tableView: UITableView )
    {
       if shots[index].likeUserAutho == true {
            Alamofire.request(.POST, "https://api.dribbble.com/v1/shots/\(shots[index].idShots)/like?access_token=\(myToken)").responseJSON { respons in
               // print(respons)
            
            }
            shots[index].likeUserAutho = true
        }
        else
       {
            Alamofire.request(.DELETE, "https://api.dribbble.com/v1/shots/\(shots[index].idShots)/like?access_token=\(myToken)")
            shots[index].likeUserAutho = false
        
        }
        Cache.UpdateCacheShots(shots) // can be optimized if need
        
        tableView.reloadData()
    }
    
    
    func ofCountItem()->Int
    {
        return countItem
    }
    func retutnItem(id: Int, tableView: UITableView) -> Item
    {
        print(id)
        print(shots.count)
        if id == shots.count-2
        {
            numberPageShots++
            LoadShot(tableView, storyboard: self.storyboard, navigationController: self.navigationController)
        }
        
        return item[id]
       
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
        }
        else{
            imageLike  = UIImage(named: "dlike")
        }

        let item = Item(title: title, description: description, imageURL: imageURL!, userAvatarUrl: userAvatarUrl, imageLike: imageLike)
        
        return item
    }
    struct Item {
        let title: String
        let description: String
        let imageURL: String!
        let userAvatarUrl: String!
        let imageLike: UIImage!
        
        
    }
}

