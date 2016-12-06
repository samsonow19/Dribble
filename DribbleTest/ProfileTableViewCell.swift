//
//  ProfileTableViewCell.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ProfileTableViewCell:   UITableViewCell, iCarouselDelegate, iCarouselDataSource  {
    var FollowerIcarausel = Follower()
    
    @IBOutlet var ViewCarousel: UIView!
    var Likes = LikeGlobal
    
    @IBOutlet var Name: UILabel!
    @IBOutlet var NumberLikes: UILabel!
    @IBOutlet var MyCarousel: iCarousel!
    @IBOutlet var ImageProfile: UIImageView!
    var viewModel = LikeViewModel()

    var count: Int!
    override func awakeFromNib() {
       
        MyCarousel.type = .CoverFlow2
        super.awakeFromNib()
        //print(FollowerIcarausel.authorName)
        viewModel.LoadFollower(FollowerIcarausel, carousel: MyCarousel)
        viewModel.LoadLikes()
        
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
        
     
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
     
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
       
        return viewModel.returnCountLike()
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
       
        return viewModel.CreateView(index)
        
    }
   
    
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.Spacing{
            
            return value*1.1
            
        }
        
        return value
    }

}
