//
//  Post.swift
//  c1-test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import Gloss

public struct Post: Decodable {
    
    public let text: String
    public let createdAt: String
    
    public let user: User
    
    public init?(json: JSON) {
        self.text = ("text" <~~ json)!
        self.createdAt = ("created_at" <~~ json)!
        
        self.user = ("user" <~~ json)!
    }
}