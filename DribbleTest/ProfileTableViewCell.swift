//
//  ProfileTableViewCell.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ProfileTableViewCell:   UITableViewCell, iCarouselDelegate, iCarouselDataSource  {
    
    var Likes = LikeGlobal
    
    @IBOutlet var Name: UILabel!
    @IBOutlet var NumberLikes: UILabel!
    @IBOutlet var MyCarousel: iCarousel!
    @IBOutlet var ImageProfile: UIImageView!
    
    
    var count: Int!
    
    
    override func awakeFromNib() {
        
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
       // super.setSelected(false, animated: false)
        
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
        // Configure the view for the selected state
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return Likes.count
    }
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
      
        
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        
        
       //tempView.backgroundColor = UIColor.blueColor()
        print(Likes[0].avatart_url)
        let image = UIImageView()
        image.sd_setImageWithURL(NSURL(string: Likes[index].avatart_url), placeholderImage: UIImage(named: "placeHolder"))
        
        
        
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        tempView.addSubview(image)
        
        
        
        
        
        return tempView
    }
   
    
    
    func carousel(carousel: iCarousel, var valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.Spacing{
            
            return value*5
            
        }
        return value
    }

}
