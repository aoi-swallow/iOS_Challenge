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
    
    // 記事一覧取得
    // - GET /api/v2/items
    struct itemsGet: GatewayApiServiceTargetType {
        let query: String
        let page: Int
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.itemsGet.path }
        var task: Task {
            return .requestParameters(parameters: ["per_page": 10,"query": query, "page": page], encoding: URLEncoding.default)
        }
    }
    
    
    // MARK: ApiServiceTargetType
    
    // 記事のストック
    // - PUT /api/v2/items/:item_id/stock
    struct stockItem: ApiServiceTargetType {
        let itemID: String
        
        var method: Moya.Method { return .put }
        var path: String { return URLConstants.AppURL.stockItem(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
}
