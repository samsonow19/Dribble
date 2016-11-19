//
//  CommentsViewController.swift
//  DribbleTest
//
//  Created by Admip on 26.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit
import Alamofire

class CommentsViewController: ViewController, UITableViewDataSource, UITableViewDelegate {


    var rControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet var CommenText: UITextField!
    var indexshot = Int()
   
    let api_comment = DriblComments()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idShot = shotsGlobal[indexshot].idShots
        commentsGlobal = [Comments]()
        indexShots = indexshot
        
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refreshcontrol", forControlEvents:.ValueChanged)
        self.tableView.addSubview(rControl)
        
        
        if TestInternetConnection.connectedToNetwork() == true {
            api_comment.loadShots(didLoadComments,id: indexShots)
        }
        else {
            Cache.GetComments()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
     
    }
    
    func refreshcontrol()
    {
       
        let api = DriblComments()
        api.loadShots(didLoadComments, id: indexShots)
        rControl.endRefreshing()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func didLoadComments(comments_ : [Comments]){
        
         commentsGlobal = [Comments]()        
        for cm in comments_{
            let data = NSData(contentsOfURL: NSURL(string: cm.avatar_url)!)
            cm.avatarImageNSData = data
            commentsGlobal.append(cm)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        Cache.UpdateCacheComments()
       
    }
    func didUpComments(comments_ : [Comments]){
        for cm in comments_{
            let data = NSData(contentsOfURL: NSURL(string: cm.avatar_url)!)
            cm.avatarImageNSData = data
            commentsGlobal.append(cm)
        }
        Cache.UpdateCacheComments()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsGlobal.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentsTableViewCell") as! CommentsTableViewCell
        var comment_ : Comments
    
         comment_ = commentsGlobal[indexPath.row]
        cell.CommentImage.sd_setImageWithURL(NSURL(string: comment_.avatar_url), placeholderImage: UIImage(named: "placeHolder"))
        cell.CommentLabel.text = comment_.body.stringByReplacingOccurrencesOfString("<[^>]+>",withString: "",  options: .RegularExpressionSearch, range: nil)
        
        cell.NameAvtorLabel.text = comment_.userName
        cell.CommentImage.userInteractionEnabled = true
        
        let tapRecog = UITapGestureRecognizer(target: self, action: "imgTap:")
        
        cell.CommentImage.addGestureRecognizer(tapRecog)
        
    
        if TestInternetConnection.connectedToNetwork() == true {
            let data = NSData(contentsOfURL: NSURL(string: comment_.avatar_url)!)
            if shotsGlobal[indexShots].commentCount > commentsGlobal.count {
                if indexPath.row == commentsGlobal.count-1 {
                    numberPageComments += 1
                    api_comment.loadShots(didUpComments,id: indexshot)
                    Cache.UpdateCacheComments()
                }
            }
        }
     
        return cell
    }
    func imgTap(gestureRecognizer: UITapGestureRecognizer)
    {
        let touch = gestureRecognizer.locationInView(self.tableView)
        
        let tapImg = gestureRecognizer.view!
    
        var indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        
        
        print(indexPath.row )
        
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        print(commentsGlobal)
         profileViewController.openUserID = commentsGlobal[indexPath.row].userId
        
       // profileViewController.indexComments = indexPath.row
        self.navigationController!.pushViewController(profileViewController, animated: true)
       
    }
   
    @IBAction func SubmitComment(sender: AnyObject) {
       // print(myToken)
        //print(shotsGlobal[indexshot].commentsURL)
        Alamofire.request(.POST, shotsGlobal[indexshot].commentsURL , parameters: ["body" : "Good", "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
        print(respons)
        }
         
        
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let detailsVC : ProfileViewController = segue.destinationViewController as! ProfileViewController
        detailsVC.indexComments = indexPath.row
        
        //numberPageComments = 0
    }
    
    


}
