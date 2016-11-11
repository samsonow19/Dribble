//
//  ShotsTableViewController.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ShotsTableViewController: UITableViewController{
    
    @IBAction func butUp(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TestInternetConnection.connectedToNetwork() == true {
            shots = [Shots]()
            let api = DriblShots()
            api.loadShots(didLoadShots)
        }
    }
    func didLoadShots(shots_: [Shots]){
        
       
       
        for sh in shots_{
            let data = NSData(contentsOfURL: NSURL(string: sh.imageURL)!)
            sh.imageData = data
            shots.append( sh)
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
            shots.append( sh)
        }
        Cache.UpdateCacheShots()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return shots.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var shot_ : Shots
        shot_ = shots[indexPath.row]
        
        
        //tag 100 - image; 101 - title; 102 -description; 103 - id_sho
       
        let celltitle : UILabel = (cell.viewWithTag(101) as? UILabel)!
        celltitle.text = shot_.title
        let celldescription :UILabel = (cell.viewWithTag(102) as? UILabel)!
        celldescription.text = shot_.descriptions.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        let id_shot : UILabel = (cell.viewWithTag(103) as? UILabel)!
        var imgg : UIImage?
        id_shot.text = String(shot_.idShots)
        if TestInternetConnection.connectedToNetwork() == true {
            let data = NSData(contentsOfURL: NSURL(string: shot_.imageURL)!)
         
            shot_.imageData = data
            imgg = UIImage(data: data!)!
            let cellimg : UIImageView = (cell.viewWithTag(100) as? UIImageView)!
            cellimg.image = imgg!
            
            if indexPath.row == shots.count-1 {
                numberPageShots += 1
                let api = DriblShots()
                api.loadShots(didLoadShots)
            }
        }
        else{
            imgg = UIImage(data: shot_.imageData!)!
            let cellimg : UIImageView = (cell.viewWithTag(100) as? UIImageView)!
            cellimg.image = imgg!
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
    }
}
