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
        super.viewDidLoad()
      
        api_comment.loadShots(didLoadComments,id: indexshot)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func didLoadComments(comments_ : [Comments]){
        
        for cm in comments_{
            let data = NSData(contentsOfURL: NSURL(string: cm.avatar_url)!)
            cm.avatarImageNSData = data
            comments.append(cm)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
       
    }
    func didUpComments(comments_ : [Comments]){
        for cm in comments_{
            let data = NSData(contentsOfURL: NSURL(string: cm.avatar_url)!)
            cm.avatarImageNSData = data
            comments.append(cm)
        }
        tableView.reloadData()
    }
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as UITableViewCell
        var comment_ : Comments
        comment_ = comments[indexPath.row]
        let data = NSData(contentsOfURL: NSURL(string: comment_.avatar_url)!)
        var imgg : UIImage?
        comment_.avatarImageNSData = data
        imgg = UIImage(data: data!)!
        // 105 - image 101 - name avtor 102 - comments {? 100 - eroro}
        let cellimage : UIImageView = (cell.viewWithTag(105) as? UIImageView)!
        cellimage.image = imgg
        let cellname : UILabel = (cell.viewWithTag(101) as? UILabel
        )!
        cellname.text = comment_.userName
        let cellcomments : UILabel = (cell.viewWithTag(102) as? UILabel)!
        cellcomments.text = comment_.body.stringByReplacingOccurrencesOfString("<[^>]+>",withString: "",  options: .RegularExpressionSearch, range: nil)
        if indexPath.row == comments.count-1 {
            api_comment.loadShots(didUpComments,id: indexshot)
        }
        return cell
    }
    
   
    @IBAction func SubmitComment(sender: AnyObject) {
        print(myToken)
        print(shots[indexshot].commentsURL)
        Alamofire.request(.POST, shots[indexshot].commentsURL , parameters: ["body" : "Good", "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
        print(respons)
        }
         
        
       
    }


}
