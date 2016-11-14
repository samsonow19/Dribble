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


    @IBOutlet var CommenText: UITextField!
    var indexshot = Int()
   
    let api_comment = DriblComments()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        idShot = shotsGlobal[indexshot].idShots
        commentsGlobal = [Comments]()
        indexShots = indexshot
        super.viewDidLoad()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func didLoadComments(comments_ : [Comments]){
        
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
        print(indexShots)
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
    
   
    @IBAction func SubmitComment(sender: AnyObject) {
       // print(myToken)
        //print(shotsGlobal[indexshot].commentsURL)
        Alamofire.request(.POST, shotsGlobal[indexshot].commentsURL , parameters: ["body" : "Good", "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
        print(respons)
        }
         
        
       
    }


}
