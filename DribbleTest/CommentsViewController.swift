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
    
    @IBOutlet var messageInputContainerView: UIView!
    @IBOutlet var inputTextField: UITextView!
    @IBOutlet var sendButton: UIButton!
    var bottomConstreint: NSLayoutConstraint?
    var rControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet var CommenText: UITextField!
    var indexshot = Int()
    var idShot = Int()
    var urlComment = String()
    var viewModel = CommentViewModel()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadIdShot(idShot)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.loadUrl(urlComment)
        viewModel.loadComments(didLoadComments)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardNotification:" as Selector, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardNotification:" as Selector, name: UIKeyboardWillHideNotification, object: nil)
        
        bottomConstreint = NSLayoutConstraint(item: messageInputContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
         view.addConstraint(bottomConstreint!)
        
        rControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rControl.addTarget(self, action: "refreshcontrol", forControlEvents:.ValueChanged)
        self.tableView.addSubview(rControl)
     
    }
    
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
            print(keyboardFrame)
            let isKeyboardShowing = notification.name == UIKeyboardWillShowNotification
            bottomConstreint?.constant = isKeyboardShowing ? -keyboardFrame!.height: 0
        }
    }
    
    func didLoadComments() {
        tableView.reloadData()
    }
    
    func didAddComment() {
        viewModel.loadComments(didLoadComments)
    }
    
    func refreshcontrol() {
        viewModel.loadComments(didLoadComments)
        rControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ofCountItem()
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.ofCountItem()-2 {
            if viewModel.ofCountItem() > 10 {
                viewModel.loadComments(didLoadComments)
            }
        }
        return setupCellWithViewModel(indexPath.row)
    }
    
    func setupCellWithViewModel(indexPath :Int)-> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentsTableViewCell") as! CommentsTableViewCell
        let item = viewModel.commentItem(indexPath)
        cell.CommentImage.sd_setImageWithURL(NSURL(string: item.avatarUrl), placeholderImage: UIImage(named: "Placeholder"))
        cell.CommentLabel.text = item.body
        cell.NameAvtorLabel.text = item.nameAvtor
        cell.CommentImage.userInteractionEnabled = true
        let tapRecog = UITapGestureRecognizer(target: self, action: "imgTap:")
        cell.CommentImage.addGestureRecognizer(tapRecog)
        return cell
    }
    
    func imgTap(gestureRecognizer: UITapGestureRecognizer) {
        let touch = gestureRecognizer.locationInView(self.tableView)
        let indexPath : NSIndexPath = self.tableView.indexPathForRowAtPoint(touch)!
        let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileViewController.openUserID = viewModel.commentUserID(indexPath.row)
        self.navigationController!.pushViewController(profileViewController, animated: true)
       
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let detailsVC : ProfileViewController = segue.destinationViewController as! ProfileViewController
        detailsVC.indexComments = indexPath.row
        
    }
    
    @IBAction func ActionSend(sender: AnyObject) {
        viewModel.addComment(CommenText.text!, completion: didAddComment)
    }
}
