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
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.LoadComponent(urlComment, Idshot: idShot, tableView: self.tableView, storyboard: self.storyboard!,  navigationController: self.navigationController!)
        
        viewModel.LoadComments()
        
        
        
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
       
            bottomConstreint?.constant = isKeyboardShowing ? -keyboardFrame!.height: 0 // very cool
        
        }
    }
    
    

    
    
    
    
    func refreshcontrol()
    {
       
        viewModel.LoadComments()
       // api.loadShots(didLoadComments, id: indexShots)
        rControl.endRefreshing()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ofCountItem()
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return   viewModel.returnCell( indexPath.row, tableView: self.tableView, target: self)
    }
    
    
    func imgTap(gestureRecognizer: UITapGestureRecognizer)
    {
        

        viewModel.GoToProfileController(gestureRecognizer)
       
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let detailsVC : ProfileViewController = segue.destinationViewController as! ProfileViewController
        detailsVC.indexComments = indexPath.row
        
        //numberPageComments = 0
    }
    
    
    @IBAction func ActionSend(sender: AnyObject) {
        
        viewModel.AddComment(CommenText.text!)
        
    }


}
