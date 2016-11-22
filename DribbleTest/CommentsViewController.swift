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
    
    @IBOutlet var inputTextField: UITextView!
    
    @IBOutlet var sendButton: UIButton!


    var rControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet var CommenText: UITextField!
    var indexshot = Int()
   
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.redColor()
        return view
    }()
    /*
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        return textField
    }()*/
    
    let api_comment = DriblComments()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idShot = shotsGlobal[indexshot].idShots
        commentsGlobal = [Comments]()
        indexShots = indexshot
       
        //setupInputComponents()
        
        /*
        view.addConstraints(myConstraint)
        myConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0(48)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["":commentInputContainerView])
        
        view.addConstraints(myConstraint)*/
      //  view.addConstraintsw
        
       // view.addSubview(messageInputContainerView)
        
        
     
        
     //   view.addConstraintsWithFormat("H:|[v0]|", views: messageInputContainerView)
      //  view.addConstraintsWithFormat("V:[v0(100)]", views: messageInputContainerView)
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("handleKeyboardNotification", object: nil)
        
        
        
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
    
    func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
            print(keyboardFrame)
            /*
            let isKeyboardShowing = notification.name == UIKeyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
                }, completion: { (completed) in
                    
                    if isKeyboardShowing {
                        let indexPath = NSIndexPath(forItem: self.messages!.count - 1, inSection: 0)
                        self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                    }
                    
            })*/
        }
    }
    
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
       // messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
       // messageInputContainerView.addConstraintsWithFormat("H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
        
        messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: inputTextField)
       // messageInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: sendButton)
        
        messageInputContainerView.addConstraintsWithFormat("H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat("V:|[v0(0.5)]", views: topBorderView)
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
        cell.CommentImage.sd_setImageWithURL(NSURL(string: comment_.avatar_url), placeholderImage: UIImage(named: "Placeholder"))
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let detailsVC : ProfileViewController = segue.destinationViewController as! ProfileViewController
        detailsVC.indexComments = indexPath.row
        
        //numberPageComments = 0
    }
    
    
    @IBAction func ActionSend(sender: AnyObject) {
        
        Alamofire.request(.POST, shotsGlobal[indexshot].commentsURL , parameters: ["body" : inputTextField.text , "access_token" : myToken], encoding: .JSON ).responseJSON{ respons in
            print(respons)
        }
        api_comment.loadShots(didLoadComments,id: indexShots)
        tableView.reloadData()
    }


}
