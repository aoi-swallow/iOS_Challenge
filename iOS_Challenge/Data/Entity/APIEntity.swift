//
//  APIEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation

struct AccessTokenRequest: Codable {
    
    var clientID: String
    var clientSecret: String
    var code: String
    
    private enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case code
    }
}

struct AccessTokenResponse: Codable {
    
    var clientID: String
    var scopes: [String]
    var token: String
    
    private enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case scopes
        case token
    }
}
