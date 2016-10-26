//
//  CommentsViewController.swift
//  DribbleTest
//
//  Created by Admip on 26.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class CommentsViewController: ViewController {

    var indexshot = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(indexshot)
        print(shots[indexshot].id)
        
        let api_comment = DriblComments()
        api_comment.loadShots(didLoadComments,id: indexshot)
     
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
    func didLoadComments(comments_ : [Comments]){
        comments = comments_
        print(comments)
        
      
        
    }


}
