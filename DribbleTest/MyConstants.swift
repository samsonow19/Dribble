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
