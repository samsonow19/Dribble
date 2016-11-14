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
    
    @IBAction func butUp(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TestInternetConnection.connectedToNetwork() == true {
            shotsGlobal = [Shots]()
            let api = DriblShots()
            api.loadShots(didLoadShots)
        }
    }
    func didLoadShots(shots_: [Shots]){
        
       
       
        for sh in shots_{
            let data = NSData(contentsOfURL: NSURL(string: sh.imageURL)!)
            sh.imageData = data
            shotsGlobal.append( sh)
        }
        Cache.UpdateCacheShots()
        //self.tableView.reloadData()
        
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
        self.tableView.reloadData()
    })
    }
    func didUploadingShots(shots_: [Shots]){
        for sh in shots_{
            let data = NSData(contentsOfURL: NSURL(string: sh.imageURL)!)
            sh.imageData = data
            shotsGlobal.append( sh)
        }
        Cache.UpdateCacheShots()
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

        
        if TestInternetConnection.connectedToNetwork() == true {
            
                if indexPath.row == shotsGlobal.count-1 {
                    numberPageShots += 1
                    let api = DriblShots()
                    api.loadShots(didLoadShots)
                }
            
        }
    
        
     
        
        return cell
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
