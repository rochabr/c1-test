//
//  Data.swift
//  c1-test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import Gloss

public struct Data: Decodable {
    
    public let entries: [Post]?
    
    public init?(json: JSON) {
        self.entries = "data" <~~ json
    }
    
}