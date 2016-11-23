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
    let apiCheckLike = DriblLikeUser()
    var numberShot = 0
    @IBAction func butUp(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refreshcontrol", forControlEvents:.ValueChanged)
        self.tableView.addSubview(rControl)
        
        if TestInternetConnection.connectedToNetwork() == true {
            shotsGlobal = [Shots]()
            let api = DriblShots()
            api.loadShots(didLoadShots)
            /*let api = DriblUser()
            api.loadUsers(didLoadUser, id: 0, urlStringParam: "https://api.dribbble.com/v1/user?access_token=\(myToken)") // get id Authenticated User  */
        }
        
        
        
        
        
        
    }
    func didLoadUser(users_: [User]){
        IdUserAuthenticated =  users_[0].idUser
    }
    
    
    func refreshcontrol()
    {
        print(numberPageShots)
        
        let api = DriblShots()
        api.loadShots(didLoadShots)
        
       
        
    }
    
    func didLoadShots(shots_: [Shots]){
        
        shotsGlobal = [Shots]()
        for sh in shots_{
            let data = NSData(contentsOfURL: NSURL(string: sh.imageURL)!)
            sh.imageData = data
            shotsGlobal.append( sh)
            apiCheckLike.loadCheckLike(didLoadChekLike, urlStringParam1: "https://api.dribbble.com/v1/shots/\(sh.idShots)/like?access_token=\(myToken)")
        }
       
       
    }
    func didUploadingShots(shots_: [Shots]){
        for sh in shots_{
            let data = NSData(contentsOfURL: NSURL(string: sh.imageURL)!)
            sh.imageData = data
            shotsGlobal.append( sh)
        }
      
        //Cache.UpdateCacheShots()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return shotsGlobal.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShotsTableViewCell") as! ShotsTableViewCell
        
        var shot_ : Shots
        shot_ = shotsGlobal[indexPath.row]
        
        
        
        cell.ImageShot.sd_setImageWithURL(NSURL(string: shot_.imageURL), placeholderImage: UIImage(named: "placeHolder"))
        
        cell.TitleShot.text = shot_.title
        
        cell.DescriptionShot.text = shot_.descriptions.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        
        cell.ImageShotAvtor.sd_setImageWithURL(NSURL(string: shot_.userAvatarUrl), placeholderImage: UIImage(named: "placeHolder"))
        
        
        
            if shot_.likeUserAutho == true
            {
                cell.ImageShotLike.image = UIImage(named: "lheart")
            }
            else{
                cell.ImageShotLike.image = UIImage(named: "dlike")
            }
        
        
        
        
        
        
        cell.ImageShotAvtor.userInteractionEnabled = true
        
        let tapRecog = UITapGestureRecognizer(target: self, action: "imgTappUser:")
        
        cell.ImageShotAvtor.addGestureRecognizer(tapRecog)
        
        
        
 
        
        cell.ImageShotLike.userInteractionEnabled = true
        
        let tapRecoglike = UITapGestureRecognizer(target: self, action: "imgTappLike:")
        
        cell.ImageShotLike.addGestureRecognizer(tapRecoglike)
        
        
        if TestInternetConnection.connectedToNetwork() == true {
            
                if indexPath.row == shotsGlobal.count-1 {
                    numberPageShots += 1
                    let api = DriblShots()
                    api.loadShots(didLoadShots)
                }
            
        }
    
        
     
        
        return cell
    }
    func didLoadChekLike(flag: Bool)
    {
        shotsGlobal[numberShot].likeUserAutho = flag;
        numberShot++
        if numberShot == shotsGlobal.count-1
        {
            self.rControl.endRefreshing()
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.tableView.reloadData()
            
            
            })
            Cache.UpdateCacheShots()
        }
    }
        
    
    func imgTappUser(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
        
      //  let tapImg = gestureRecognizer.view!
        
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        
        
        print(indexPath.row )
        
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        
        
        profileViewController.openUserID = shotsGlobal[indexPath.row].userID
        
        // profileViewController.indexComments = indexPath.row
        self.navigationController!.pushViewController(profileViewController, animated: true)
        
    }
    
    func imgTappLike(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
        
        //  let tapImg = gestureRecognizer.view!
        
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        
        if shotsGlobal[indexPath.row].likeUserAutho == true {
            
            //apiCheckLike.DellLikeShot("https://api.dribbble.com/v1/shots/\(shotsGlobal[indexPath.row].idShots)/like?access_token=\(myToken)")
            shotsGlobal[indexPath.row].likeUserAutho = false
        }
        else {
            
            
            //apiCheckLike.LikeShot("https://api.dribbble.com/v1/shots/\(shotsGlobal[indexPath.row].idShots)/like?access_token=\(myToken)")
            shotsGlobal[indexPath.row].likeUserAutho = true
        }
        self.rControl.endRefreshing()
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.tableView.reloadData()

        })
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
         numberPageComments = 0
    }
}
