//
//  User.swift
//  c1-test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import Gloss

public struct User: Decodable {
    
    public let username: String
    public let avatarLink: String
    
    public init?(json: JSON) {
        guard let container: JSON = "avatar_image" <~~ json
            else { return nil }
        
        guard let avatarLink: String = "url" <~~ container
            else { return nil }
        
        self.avatarLink = avatarLink
        self.username = ("username" <~~ json)!
    }
}