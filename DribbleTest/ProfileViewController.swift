//
//  ProfileViewController.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var ImageUser: UIImageView!
    @IBOutlet var LabelNameUser: UILabel!
    @IBOutlet var CountLikes: UILabel!
    @IBOutlet var CountFolowers: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var indexComments = Int()
    var openUserID: Int!
    var viewModel = ProfileViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel.loadUser(openUserID, completion: didLoadUser)
    }
    
    func didLoadUser() {
        let openUser = viewModel.itemUser()
        ImageUser.sd_setImageWithURL(NSURL(string:openUser.avatarUrl), placeholderImage: UIImage(named: "Placeholder"))
        LabelNameUser.text = openUser.name
        CountLikes.text = openUser.countLikes
        CountFolowers.text = openUser.countFollowers
        viewModel.loadFollower(didLoadFollower)
    }
    
    func didLoadFollower() {
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.followersCount()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.followers.count-2 && viewModel.followers.count > 10 {
                viewModel.loadFollower(didLoadFollower)
        }
       
        return setupCellWithViewModel(indexPath.row)
    }
    
    func setupCellWithViewModel(indexPath :Int)-> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell") as! ProfileTableViewCell
        cell.followerIcarausel = viewModel.follower(indexPath)
        let item = viewModel.itemFollower(indexPath)
        cell.ImageProfile.sd_setImageWithURL(NSURL(string: item.imageProfile), placeholderImage: UIImage(named: "Placeholder"))
        cell.Name.text = item.name
        cell.NumberLikes.text = String(item.numberLikes)
        return cell
    }

}
