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
    @IBOutlet var Name: UILabel!
    @IBOutlet var NumberLikes: UILabel!
    @IBOutlet var MyCarousel: iCarousel!
    @IBOutlet var ImageProfile: UIImageView!
    var viewModel = LikeViewModel()
    
    override func awakeFromNib() {
        MyCarousel.type = .CoverFlow2
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        viewModel.LoadFollower(FollowerIcarausel)
        viewModel.LoadLikes(didLoadLikes)
        self.MyCarousel.delegate = self
        self.MyCarousel.dataSource = self
    }
    
    func didLoadLikes() {
        MyCarousel.reloadData()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
       
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
       
        return viewModel.returnCountLike()
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        if index % 12 == 10 && index > viewModel.returnCountLike()-3{
            viewModel.LoadLikes(didLoadLikes)
        }
        
        let item = viewModel.returnItemLike(index)
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
        CarauselLableTittleShot.text = item.titleShot
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
   
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.Spacing{
            return value*1.1
        }
        return value
    }
}
