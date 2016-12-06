//
//  ShotsTableViewController.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit
import SDWebImage

class ShotsTableViewController: UITableViewController{
    

    @IBOutlet var likeImage: UIImageView!
    
    var rControl: UIRefreshControl = UIRefreshControl()

    
    var numberShot = 0
    
    var viewModel =  ShotViewModel()
    
    @IBAction func butUp(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refreshcontrol", forControlEvents:.ValueChanged)
        self.tableView.addSubview(rControl)
        viewModel.LoadShot(self.tableView, storyboard: self.storyboard!, navigationController: self.navigationController!)
       
        
    }
    
    func refreshcontrol()
    {
       
        viewModel.LoadShot(self.tableView, storyboard: self.storyboard!, navigationController: self.navigationController!)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.ofCountItem()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShotsTableViewCell") as! ShotsTableViewCell
      
   
        return  viewModel.returnCell(cell, index: indexPath.row, tableView: self.tableView, target: self)
    }
  
        
    
    func imgTappUser(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
        

        
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
      
        profileViewController.openUserID = viewModel.getIdUser(indexPath.row)
      
        self.navigationController!.pushViewController(profileViewController, animated: true)
        
    }


    func imgTappLike(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        viewModel.Like(indexPath.row, tableView: self.tableView)
     
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
               return true
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let detailsVC : CommentsViewController = segue.destinationViewController as! CommentsViewController
        detailsVC.indexshot = indexPath.row
        detailsVC.idShot = viewModel.getIdShot(indexPath.row)
      
        detailsVC.urlComment = viewModel.getUrlComment(indexPath.row)
        //numberPageComments = 0
    }
}
