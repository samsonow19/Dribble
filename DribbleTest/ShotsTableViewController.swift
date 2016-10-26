//
//  ShotsTableViewController.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit


class ShotsTableViewController: UITableViewController{
 
    
    
    //var shots: [Shots]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        shots = [Shots]()
        let api = DriblShots()
        api.loadShots(didLoadShots)
        print(shots)
     
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func didLoadShots(shots_: [Shots]){
        shots = shots_
        //self.tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
        self.tableView.reloadData()
    })
        //tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return shots.count
        //return 0
        return shots.count
    }

    
    
    
    
    
    
    
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var shot_ : Shots
        print(shots)
        
        shot_ = shots[indexPath.row]
       // cell.textLabel?.text = shot_.title
        
        
        
        var data = NSData(contentsOfURL: NSURL(string: shot_.imageURL)!)
        var imgg : UIImage?
        shot_.imageData = data
        imgg = UIImage(data: data!)!
        
        //tag 100 - image; 101 - title; 102 -description; 103 - id_sho
        // cell.imageView?.image = imgg
        let cellimg : UIImageView = (cell.viewWithTag(100) as? UIImageView)!
        cellimg.image = imgg!
        let celltitle : UILabel = (cell.viewWithTag(101) as? UILabel)!
        celltitle.text = shot_.title
        let celldescription :UILabel = (cell.viewWithTag(102) as? UILabel)!
        celldescription.text = shot_.descriptions.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        
        
        let id_shot : UILabel = (cell.viewWithTag(103) as? UILabel)!
        id_shot.text = String(shot_.id)
        // Configure the cell...
        //print(shots)
        return cell
    }
  

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
/*
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        
        return true
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
    
        let detailsVC : CommentsViewController = segue.destinationViewController as! CommentsViewController

        
        detailsVC.indexshot = indexPath.row
        
      
     
    }


}
