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
  
    override func viewDidLoad() {
        super.viewDidLoad()
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refreshcontrol", forControlEvents:.ValueChanged)
        self.tableView.addSubview(rControl)
        viewModel.LoadShot(didLoadShot)
    }
    
    func refreshcontrol() {
        viewModel.LoadShot(didLoadShot)
    }
    
    func didLoadShot() {
        tableView.reloadData()
        self.rControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ofCountItem()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShotsTableViewCell") as! ShotsTableViewCell
        let item = viewModel.retutnItem(indexPath.row)
        if indexPath.row == viewModel.countItem-2
        {
            viewModel.LoadShot(didLoadShot)
        }
        cell.ImageShot.sd_setImageWithURL(NSURL(string: item.imageURL), placeholderImage: UIImage(named: "Placeholder"))
        cell.TitleShot.text = item.title
        cell.DescriptionShot.text = item.description
        cell.ImageShotAvtor.sd_setImageWithURL(NSURL(string: item.userAvatarUrl), placeholderImage: UIImage(named: "Placeholder"))
        cell.ImageShotLike.image = item.imageLike
        cell.ImageShotAvtor.userInteractionEnabled = true
        
        let tapRecog = UITapGestureRecognizer(target: self, action: "imgTappUser:")
        cell.ImageShotAvtor.addGestureRecognizer(tapRecog)
        cell.ImageShotLike.userInteractionEnabled = true
        
        let tapRecoglike = UITapGestureRecognizer(target: self, action: "imgTappLike:")
        cell.ImageShotLike.addGestureRecognizer(tapRecoglike)

        return  cell
    }
  
    func imgTappUser(gestureRecognizer: UITapGestureRecognizer) {
        let touch = gestureRecognizer.locationInView(self.tableView)
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        
        profileViewController.openUserID = viewModel.getIdUser(indexPath.row)
        self.navigationController!.pushViewController(profileViewController, animated: true)
    }


    func imgTappLike(gestureRecognizer: UITapGestureRecognizer) {
        let touch = gestureRecognizer.locationInView(self.tableView)
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        viewModel.Like(indexPath.row, completion: didLoadShot)
     
    }

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
    }
}
