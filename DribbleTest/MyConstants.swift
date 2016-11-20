//
//  MyConstants.swift
//  DribbleTest
//
//  Created by Admip on 20.10.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import Foundation
import OAuthSwift

let oauthswift = OAuth2Swift(
    consumerKey:    "e5dfd06e7f32f8093dd689e6146892f376c48207b85df0e8d5662c340c85006e",
    consumerSecret: "9e98a036a8f7ed33c69d196eae551321dd8cf62e7da7b26c736b9bb449b895b8",
    authorizeUrl:   "https://dribbble.com/oauth/authorize",
    accessTokenUrl: "https://dribbble.com/oauth/token",
    responseType:   "code"
)
//public var shots: [Shots] = [Shots]()
public var flag: Bool = false
public var shotid : Int!
var shotsGlobal: [Shots]!
var commentsGlobal: [Comments]!
var usersGlobal: [User]!
var LikeGlobal: [Like]!


var myToken : String!
var numberPageShots = 1
var numberPageComments = 1

var idShot = 0
var indexShots = 0


extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

