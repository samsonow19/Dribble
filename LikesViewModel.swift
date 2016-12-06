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
    var follower: Follower!
    var carousel: iCarousel!
  
    var count = 0
    var indexFollower = 0
    var numberPageLike = 0
    var itemLike = [ItemLike]()
    func LoadFollower(follower : Follower,carousel : iCarousel )
    {
        self.carousel = carousel
       // print(follower.authorName)
        self.follower = FollowerGlobal
    }
    

  
    
    func LoadLikes()
    {
        
        if TestInternetConnection.connectedToNetwork() == true
        {
        Alamofire.request(.GET, self.follower.likesURL!+"?page=\(self.numberPageLike)&access_token=\(myToken)").responseJSON{ respons in
            let JsonResult = respons.2.value as! NSArray!
            if JsonResult != nil
            {
                
                for like in JsonResult!{
                    self.follower.likes.append(Like(data: like as! NSDictionary))
                    print(self.follower.likes.last)
                    self.itemLike.append(self.itemForLike(self.follower.likes.last!))

                }
            }
            else
            {
                self.follower.likes.append(Like())
            }
            print(self.count)
            print(self.follower.numberLike)

            self.carousel.reloadData()
            Cache.UpdateCasheLikes(self.follower.likes, id: self.follower.idUser)
          
           
        }
        }
        else
        {
            self.follower.likes = Cache.GetLikes( self.follower.likesURL)
        }
    }
    func returnCountLike()-> Int
    {
       
      
        return follower.likes.count
        
    }
    
    func itemForLike(like: Like) -> ItemLike {
        
        let avatarUrl = like.avatart_url
        let name = like.name
        let titleShot = like.title_shot
        
        /*let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.dateFromString(like.date) else {
            assert(false, "no date")
         
        }

        let time = dateFormatter.stringFromDate(date)*/
        
        
        let item = ItemLike(avatarUrl: avatarUrl, name: name, title_shot: titleShot, date: "123")
        
        return item
    }
    
    func returnItemLike(id: Int)-> ItemLike
    {
        if id == follower.likes.count-2
        {
            if follower.likes.count > 10
            {
                numberPageLike++
                LoadLikes()
            }
        }
        
        return itemLike[id]
    }
    func CreateView(index : Int)-> UIView
    {
        let item = returnItemLike(index)
        
        let temp  = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let CarouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        
        
        CarouselImage.sd_setImageWithURL(NSURL(string: item.avatarUrl), placeholderImage: UIImage(named: "placeHolder"))
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let CarauselVisualEffect = UIVisualEffectView(effect: blurEffect);
        
        
        CarauselVisualEffect.frame = CGRect(x: 0, y: 70, width: 100, height: 40)
        
        
        let CarauselLableNamePerson = UILabel();
        let CarauselLableTittleShot = UILabel()
        let CarauselLableData = UILabel();
        
        CarauselLableNamePerson.text = item.name
        
        CarauselLableNamePerson.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        CarauselLableNamePerson.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)
        
        CarauselLableTittleShot.text = item.title_shot
        
        CarauselLableTittleShot.frame = CGRect(x: 0, y: 10, width: 100, height: 20)
        
        CarauselLableTittleShot.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)
        
        CarauselLableData.text = item.date
        CarauselLableData.frame = CGRect(x: 0, y: 20, width: 100, height: 20)
        CarauselLableData.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)
        CarauselVisualEffect.addSubview(CarauselLableNamePerson)
        CarauselVisualEffect.addSubview(CarauselLableTittleShot)
        CarauselVisualEffect.addSubview(CarauselLableData)
        CarouselImage.addSubview(CarauselVisualEffect)
        
        temp.addSubview(CarouselImage)
        
        return temp
    }
    
    struct ItemLike {
        let avatarUrl: String
        let name: String
        let title_shot: String!
        let date: String
       
        
    }
}

    
        
