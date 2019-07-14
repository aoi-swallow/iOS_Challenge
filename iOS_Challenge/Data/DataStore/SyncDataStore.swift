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
    func getStockedItems() -> Single<Void>
    func getItems(query: String, page: Int) -> Single<ArticlesItemListEntity>
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
                    self?.realm.add(userInfo!, update: .error)
                }
                UserDefaults.Keys.Auth.userID.set(userInfo!.id)
                print("UserData Persed")
                observer(.success(()))
                return Disposables.create()
            }
        }
    }
    
    func getStockedItems() -> Single<Void> {
        
        let task = Api.shared.request(ApiService.LoginUserStocksGet())
        return task.flatMap { response in
            return Single.create { [weak self] observer in
                var items: [StockItemEntity] = []
                do {
                    items = try JSONDecoder().decode([StockItemEntity].self, from: response.data)
                } catch {
                    observer(.error(error))
                    return Disposables.create()
                }
                self?.realm.writeBackground(block: { (realm) in
                    realm.add(items, update: .all)
                }, completion: {
                    print("StockItems Persed")
                    observer(.success(()))
                })
                return Disposables.create()
            }
        }
    }
    
    func getItems(query: String, page: Int) -> Single<ArticlesItemListEntity> {
        
        let task = Api.shared.request(ApiService.ItemsGet(query: query, page: page))
        return task.flatMap { response in
            return Single.create { observer in
                let json = JSON(response.data)
                let items: ArticlesItemListEntity = ArticlesItemListEntity(json: json)
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
}
