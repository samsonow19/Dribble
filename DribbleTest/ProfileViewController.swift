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
    var OpenUser = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel.loadUser(openUserID, completion: didLoadUser)
    }
    
    func didLoadUser() {
        let OpenUser = viewModel.returnItemUser()
        ImageUser.sd_setImageWithURL(NSURL(string:OpenUser.avatarUrl), placeholderImage: UIImage(named: "Placeholder"))
        LabelNameUser.text = OpenUser.name
        CountLikes.text = OpenUser.countLikes
        CountFolowers.text = OpenUser.countFollowers
        viewModel.LoadFollower(didLoadFollower)
    }
    
    func didLoadFollower() {
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ReturnFollowersCount()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == viewModel.followers.count-2{
            if viewModel.followers.count > 10{
                viewModel.LoadFollower(didLoadFollower)
            }
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell") as! ProfileTableViewCell
        cell.FollowerIcarausel = viewModel.returnFollower(indexPath.row)
        let item = viewModel.retutnItemFollower(indexPath.row)
        cell.ImageProfile.sd_setImageWithURL(NSURL(string: item.imageProfile), placeholderImage: UIImage(named: "Placeholder"))
        cell.Name.text = item.name
        cell.NumberLikes.text = String(item.numberLikes)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  
    }
}
