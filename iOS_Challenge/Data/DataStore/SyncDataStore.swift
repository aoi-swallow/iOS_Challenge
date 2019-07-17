//
//  SyncDataStore.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import Moya
import RealmSwift
import RxSwift
import SwiftyJSON

// MARK: - SyncDataStore
protocol SyncDataStore {
    func getAuthorizedUserInfo() -> Single<Void>
    func getStockedItems(page: Int) -> Single<ArticlesItemListEntity>
    func getItems(query: String, page: Int) -> Single<ArticlesItemListEntity>
    func getLikedUserList(itemID: String, page: Int) -> Single<LikedUserListEntity>
    func checkLiked(itemID: String) -> Single<Response>
    func putLike(itemID: String) -> Single<Response>
    func deleteLike(itemID: String) -> Single<Response>
    func checkStocked(itemID: String) -> Single<Response>
    func putStock(itemID: String) -> Single<Response>
    func deleteStock(itemID: String) -> Single<Response>
    func getSingleItem(itemID: String) -> Single<ArticleSingleItemEntity>
    func getAuthorizedUsersItems(page: Int) -> Single<ArticlesItemListEntity>
    func getFollowingTags() -> Single<Void>
}

// MARK: - SyncDataStoreImpl
final class SyncDataStoreImpl: SyncDataStore {
    
    let realm = RealmModel.getRealm
    
    func getAuthorizedUserInfo() -> Single<Void> {
        
        let task = Api.shared.request(ApiService.UserInfoGet())
        return task.flatMap { response in
            return Single.create { [weak self] observer in
                let userInfo: AuthorizedUserEntity?
                do {
                    userInfo = try JSONDecoder().decode(AuthorizedUserEntity.self, from: response.data)
                } catch {
                    observer(.error(error))
                    return Disposables.create()
                }
                try! self?.realm.write {
                    self?.realm.add(userInfo!, update: .all)
                }
                UserDefaults.Keys.Auth.userID.set(userInfo!.id)
                print("UserData Persed")
                observer(.success(()))
                return Disposables.create()
            }
        }
    }
    
    func getStockedItems(page: Int) -> Single<ArticlesItemListEntity> {
        
        let task = Api.shared.request(ApiService.LoginUserStocksGet(page: page))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let items: ArticlesItemListEntity = ArticlesItemListEntity(json: json, count: 10)
                if items.articles.isEmpty {
                    observer(.error(NSError(domain: "elements has no data.", code: -1, userInfo: nil)))
                    return Disposables.create()
                } else {
                    observer(.success(items))
                    return Disposables.create()
                }
            }
        }
    }
    
    func getItems(query: String, page: Int) -> Single<ArticlesItemListEntity> {
        
        let task = Api.shared.request(ApiService.ItemsGet(query: query, page: page))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let items: ArticlesItemListEntity = ArticlesItemListEntity(json: json, count: 10)
                if items.articles.isEmpty{
                    observer(.error(NSError(domain: "elements has no data.", code: -1, userInfo: nil)))
                    return Disposables.create()
                } else {
                    observer(.success(items))
                    return Disposables.create()
                }
            }
        }
    }
    
    func getLikedUserList(itemID: String, page: Int) -> Single<LikedUserListEntity> {
        
        let task = Api.shared.request(ApiService.LikedUsersGet(itemID: itemID, page: page))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let items: LikedUserListEntity = LikedUserListEntity(json: json, count: 10)
                if items.likedUsers.isEmpty {
                    observer(.error(NSError(domain: "elements has no data.", code: -1, userInfo: nil)))
                    return Disposables.create()
                } else {
                    observer(.success(items))
                    return Disposables.create()
                }
            }
        }
    }
    
    func checkLiked(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.LikeCheck(itemID: itemID))
    }
    
    func putLike(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.LikePut(itemID: itemID))
    }
    
    func deleteLike(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.LikeDelete(itemID: itemID))
    }
    
    func checkStocked(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.StockCheck(itemID: itemID))
    }
    
    func putStock(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.StockItem(itemID: itemID))
    }
    
    func deleteStock(itemID: String) -> Single<Response> {
        
        return Api.shared.request(ApiService.StockDelete(itemID: itemID))
    }
    
    func getSingleItem(itemID: String) -> Single<ArticleSingleItemEntity> {
        
        let task = Api.shared.request(ApiService.ItemSingleGet(itemID: itemID))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let item: ArticleSingleItemEntity = ArticleSingleItemEntity(json: json)
                if item.body.isEmpty {
                    observer(.error(NSError(domain: "elements has no data.", code: -1, userInfo: nil)))
                    return Disposables.create()
                } else {
                    observer(.success(item))
                    return Disposables.create()
                }
            }
        }
    }
    
    func getAuthorizedUsersItems(page: Int) -> Single<ArticlesItemListEntity> {
        
        let task = Api.shared.request(ApiService.AuthorizedUserItemsGet(page: page))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let items: ArticlesItemListEntity = ArticlesItemListEntity(json: json, count: 10)
                if items.articles.isEmpty {
                    observer(.error(NSError(domain: "elements has no data.", code: -1, userInfo: nil)))
                    return Disposables.create()
                } else {
                    observer(.success(items))
                    return Disposables.create()
                }
            }
        }
    }
    
    func getFollowingTags() -> Single<Void> {
        
        let task = Api.shared.request(ApiService.FollowingTagsGet())
        return task.flatMap { [weak self] response in
            return Single.create { [weak self] observer in
                var tags: [TagDetailEntity] = []
                do {
                    tags = try JSONDecoder().decode([TagDetailEntity].self, from: response.data)
                } catch {
                    observer(.error(error))
                    return Disposables.create()
                }
                try! self?.realm.write {
                    self?.realm.add(tags, update: .all)
                }
                print("TagData Persed")
                observer(.success(()))
                return Disposables.create()
            }
        }
    }
}
