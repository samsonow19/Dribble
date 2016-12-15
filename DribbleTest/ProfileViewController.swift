//
//  ProfileViewController.swift
//  DribbleTest
//
//  Created by Admip on 15.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDataSource, UITableViewDelegate   {
    var count = 0

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
        viewModel.loadContent(self.tableView)
        viewModel.loadModel(openUserID)
        
       
        
    }
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ReturnFollowersCount()
    }
    
 
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let OpenUser = viewModel.returnItemUser()
        
        ImageUser.sd_setImageWithURL(NSURL(string:OpenUser.avatarUrl), placeholderImage: UIImage(named: "Placeholder"))
        LabelNameUser.text = OpenUser.name
        CountLikes.text = OpenUser.countLikes
        CountFolowers.text = OpenUser.countFollower
        
 
        
      
        return viewModel.returnCell(indexPath.row)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  
    }
    
    
    
    
    
    
    
    
    



}
