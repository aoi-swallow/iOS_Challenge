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
    
    enum AppURL {
        case itemsGet
        case stockItem(itemID: String)
        
        public var path: String {
            switch self {
            case .itemsGet: return "/api/v2/items"
            case .stockItem(let itemID): return "/api/v2/items/\(itemID)/stock"
            }
        }
    }
}
