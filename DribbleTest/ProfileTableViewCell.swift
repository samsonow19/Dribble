//
//  ProfileTableViewCell.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ProfileTableViewCell:   UITableViewCell, iCarouselDelegate, iCarouselDataSource  {
    @IBOutlet var ViewCarousel: UIView!
    var Likes = LikeGlobal
    @IBOutlet var Name: UILabel!
    @IBOutlet var NumberLikes: UILabel!
    @IBOutlet var MyCarousel: iCarousel!
    @IBOutlet var ImageProfile: UIImageView!
    var count: Int!
    override func awakeFromNib() {
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
        MyCarousel.type = .CoverFlow2
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
       // super.setSelected(false, animated: false)
        
       // self.MyCarousel.delegate = self
       // self.MyCarousel.dataSource = self
        // Configure the view for the selected state
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return Likes.count
    }
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
      

        let temp  = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let CarouselImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        CarouselImage.sd_setImageWithURL(NSURL(string: Likes[index].avatart_url), placeholderImage: UIImage(named: "placeHolder"))

        let blurEffect = UIBlurEffect(style: .Dark)
        let CarauselVisualEffect = UIVisualEffectView(effect: blurEffect);
        
        
        CarauselVisualEffect.frame = CGRect(x: 0, y: 70, width: 100, height: 40)
       
        
        let CarauselLableNamePerson = UILabel();
        let CarauselLableTittleShot = UILabel()
        let CarauselLableData = UILabel();
        
        CarauselLableNamePerson.text = Likes[index].name
        
        CarauselLableNamePerson.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        CarauselLableNamePerson.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)

        CarauselLableTittleShot.text = Likes[index].title_shot
        
        CarauselLableTittleShot.frame = CGRect(x: 0, y: 10, width: 100, height: 20)
        
        CarauselLableTittleShot.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)
        
        CarauselLableData.text = Likes[index].date
        CarauselLableData.frame = CGRect(x: 0, y: 20, width: 100, height: 20)
        CarauselLableData.font = UIFont(name: (CarauselLableNamePerson.font?.fontName)!, size: 10)
        CarauselVisualEffect.addSubview(CarauselLableNamePerson)
        CarauselVisualEffect.addSubview(CarauselLableTittleShot)
        CarauselVisualEffect.addSubview(CarauselLableData)
        CarouselImage.addSubview(CarauselVisualEffect)
        
        temp.addSubview(CarouselImage)
       
        
        return temp
        
    }
   
    
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.Spacing{
            
            return value*1.1
            
        }
        
        return value
    }

}
