//
//  Endpoint.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/26/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//  
//  Enum created to model API endpoints
//

import Foundation

let baseURL = "https://alpha-api.app.net/"

enum Endpoint {
    case Global
    
    func url() -> String {
        switch self {
        case .Global:
            return baseURL.stringByAppendingString("stream/0/posts/stream/global")
        }
    }
}