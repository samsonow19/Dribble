//
//  ShotsTableViewController.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ShotsTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shots = [Shots]()
        let api = DriblShots()
        api.loadShots(didLoadShots)
    }
    func didLoadShots(shots_: [Shots]){
        shots = shots_
        //self.tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
        self.tableView.reloadData()
    })
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
        let data = NSData(contentsOfURL: NSURL(string: shot_.imageURL)!)
        var imgg : UIImage?
        shot_.imageData = data
        imgg = UIImage(data: data!)!
        //tag 100 - image; 101 - title; 102 -description; 103 - id_sho
        let cellimg : UIImageView = (cell.viewWithTag(100) as? UIImageView)!
        cellimg.image = imgg!
        let celltitle : UILabel = (cell.viewWithTag(101) as? UILabel)!
        celltitle.text = shot_.title
        let celldescription :UILabel = (cell.viewWithTag(102) as? UILabel)!
        celldescription.text = shot_.descriptions.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        let id_shot : UILabel = (cell.viewWithTag(103) as? UILabel)!
        id_shot.text = String(shot_.id)
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
