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
    @IBOutlet var Name: UILabel!
    @IBOutlet var NumberLikes: UILabel!
    @IBOutlet var MyCarousel: iCarousel!
    @IBOutlet var ImageProfile: UIImageView!
    
    var viewModel = LikeViewModel()
    var followerIcarausel = Follower()
    
    override func awakeFromNib() {
        MyCarousel.type = .CoverFlow2
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        viewModel.loadFollower(followerIcarausel)
        viewModel.loadLikes(didLoadLikes)
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
    }
    
    func didLoadLikes() {
        MyCarousel.reloadData()
    }

    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return viewModel.countLike()
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        if index % 12 == 10 && index > viewModel.countLike()-3 {
            viewModel.loadLikes(didLoadLikes)
        }

        let itemLike = viewModel.itemLike(index)
        let temp = IcarouselView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        temp.imageUser.sd_setImageWithURL(NSURL(string: itemLike.avatarUrl), placeholderImage: UIImage(named: "placeHolder"))
        temp.nameUser.text = itemLike.name
        temp.titleShot.text = itemLike.titleShot
        temp.date.text = itemLike.date
 
        return temp
    }
   
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.Spacing{
            return value*1.1
        }
        return value
    }
}
