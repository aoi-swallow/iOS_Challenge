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
    
    // ログインユーザー情報取得
    // - GET /api/v2/authenticated_user
    struct UserInfoGet: ApiServiceTargetType {
        
        var method: Moya.Method { return .get}
        var path: String { return URLConstants.AppURL.authorizedUser.path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // ログインユーザーストック記事取得
    // - GET /api/v2/users/:user_id/stocks
    struct LoginUserStocksGet: ApiServiceTargetType {
        let userID = UserDefaults.Keys.Auth.userID.value()
        var page: Int
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.stockedItem(userID: userID).path}
        var task: Task {
            return .requestParameters(parameters: ["page": page, "per_page": 10], encoding: URLEncoding.default)
        }
    }
    
    // 記事取得
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
    
    // 記事単体取得
    // - GET /api/v2/items/:item_id
    struct ItemSingleGet: ApiServiceTargetType {
        var itemID: String
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.singleItem(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // いいねユーザー一覧取得
    // - GET /api/v2/items/:item_id/likes
    struct LikedUsersGet: ApiServiceTargetType {
        var itemID: String
        var page: Int
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.likeList(itemID: itemID).path }
        var task: Task {
            return .requestParameters(parameters: ["per_page": 10, "page": page], encoding: URLEncoding.default)
        }
    }
    
    // 記事にいいねをつける
    // - PUT /api/v2/items/:item_id/like
    struct LikePut: ApiServiceTargetType {
        var itemID: String
        
        var method: Moya.Method { return .put }
        var path: String { return URLConstants.AppURL.like(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 記事のいいねを取り消す
    // - DELETE /api/v2/items/:item_id/like
    struct LikeDelete: ApiServiceTargetType {
        var itemID: String
        
        var method: Moya.Method { return .delete }
        var path: String { return URLConstants.AppURL.like(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 記事のいいねを確認する
    // - GET /api/v2/items/:item_id/like
    struct LikeCheck: ApiServiceTargetType {
        var itemID: String
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.like(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 記事をストックする
    // - PUT /api/v2/items/:item_id/stock
    struct StockItem: ApiServiceTargetType {
        let itemID: String
        
        var method: Moya.Method { return .put }
        var path: String { return URLConstants.AppURL.stock(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 記事をストックから外す
    // - DELETE /api/v2/items/:item_id/stock
    struct StockDelete: ApiServiceTargetType {
        let itemID: String
        
        var method: Moya.Method { return .delete }
        var path: String { return URLConstants.AppURL.stock(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 記事のストックを確認する
    // - GET /api/v2/items/:item_id/stock
    struct StockCheck: ApiServiceTargetType {
        let itemID: String
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.stock(itemID: itemID).path }
        var task: Task {
            return .requestPlain
        }
    }
    
    // 認証中ユーザーの記事取得
    // - GET /api/v2/authenticated_user/items
    struct AuthorizedUserItemsGet: ApiServiceTargetType {
        var page: Int
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.authorizedUserItems.path}
        var task: Task {
            return .requestParameters(parameters: ["per_page": 10, "page": page], encoding: URLEncoding.default)
        }
    }
    
    // ユーザーがフォローしているタグ一覧
    // - GET /api/v2/users/:user_id/following_tags
    struct FollowingTagsGet: ApiServiceTargetType {
        let userID = UserDefaults.Keys.Auth.userID.value()
        
        var method: Moya.Method { return .get }
        var path: String { return URLConstants.AppURL.likeList(itemID: userID).path }
        var task: Task {
            return .requestParameters(parameters: ["page": 1, "per_page": 100], encoding: URLEncoding.default)
        }
    }
}
