//
//  ApiService.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/11.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya

protocol GatewayApiServiceTargetType: TargetType {}

extension GatewayApiServiceTargetType {
    var baseURL: URL { return URL(string: URLConstants.baseURL )! }
    var headers: [String : String]? { return URLConstants.jsonHeader }
    var sampleData: Data { return Data() }
}

protocol ApiServiceTargetType: TargetType {}

extension ApiServiceTargetType {
    var baseURL: URL { return URL(string: URLConstants.baseURL )! }
    var headers: [String : String]? { return URLConstants.authorizedHeader }
    var sampleData: Data { return Data() }
}


// MARK: - ApiService
enum ApiService {
    
    
    
    // MARK: GatewayApiServiceTargetType
    
    // 認証許可
    // - GET /api/v2/oauth/authorize
    struct Authorize: GatewayApiServiceTargetType {
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.auth.path }
        var task: Task {
            return .requestParameters(parameters: ["client_id": URLConstants.clientID, "scope": URLConstants.scope], encoding: URLEncoding.default)
        }
    }
    
    // アクセストークン取得
    // - POST /api/v2/access_tokens
    struct IssueAcceessToken: GatewayApiServiceTargetType {
        let request = AccessTokenRequest(clientID: URLConstants.clientID, clientSecret: URLConstants.clientSecret, code: UserDefaults.Keys.Auth.code.value())
        
        var method: Moya.Method { return .post }
        var path: String { return URLConstants.AppURL.accessToken.path }
        var task: Task {
           return .requestJSONEncodable(request)
        }
    }
    
    
    
    // MARK: ApiServiceTargetType
    
    // 記事一覧取得
    // - GET /api/v2/items
    struct ItemsGet: ApiServiceTargetType {
        let query: String
        let page: Int
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.items.path }
        var task: Task {
            return .requestParameters(parameters: ["per_page": 10,"query": query, "page": page], encoding: URLEncoding.default)
        }
    }
    
    // 記事のストック
    // - PUT /api/v2/items/:item_id/stock
    struct StockItem: ApiServiceTargetType {
        let itemID: String
        
        var method: Moya.Method { return .put }
        var path: String { return URLConstants.AppURL.stock(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
}
