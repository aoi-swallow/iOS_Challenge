//
//  URLConstants.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/11.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import KeychainAccess

struct URLConstants {
    
    static var baseURL: String {
        return "https://qiita.com"
    }
    
    static var jsonHeader: [String : String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    static var authorizedHeader: [String : String] {
        let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
        return [
            "Content-Type": "application/json",
            "Authorization" : "Bearer " + keychain[AppKey.Keychain.token.rawValue]!
        ]
    }
    
    static var clientID: String {
        return "8256b214e4a54852cf126fb28edd7130d37f2d5f"
    }
    
    static var clientSecret: String {
        return "0ec56b02dd3dcf10ab91602a06ae40763cb1a4a5"
    }
    
    static var scope: String {
        return "read_qiita+write_qiita"
    }
    
    enum AppURL {
        case auth
        case accessToken
        case items
        case stock(itemID: String)
        
        public var path: String {
            switch self {
            case .auth: return "/api/v2/oauth/authorize"
            case .accessToken: return "/api/v2/access_tokens"
            case .items: return "/api/v2/items"
            case .stock(let itemID): return "/api/v2/items/\(itemID)/stock"
            }
        }
    }
}
