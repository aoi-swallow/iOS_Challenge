//
//  ArticlesUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya
import RxSwift

// MARK: - SyncUseCase
protocol ArticlesUseCase {
    func newArrivalItemsGet(page: Int) -> Single<ArticlesItemListEntity>
    func searchItems(query: String, page: Int) -> Single<ArticlesItemListEntity>
    func getLikedUserList(itemID: String, likedCount: Int) -> Single<LikedUserListEntity>
    func checkLiked(itemID: String) -> Single<Response>
    func putLike(itemID: String) -> Single<Response>
    func deleteLike(itemID: String) -> Single<Response>
    func checkStocked(itemID: String) -> Single<Response>
    func putStock(itemID: String) -> Single<Response>
    func deleteStock(itemID: String) -> Single<Response>
    func getSingleItem(itemID: String) -> Single<ArticleSingleItemEntity>
    func readTags() -> [TagDetailEntity]
}

// MARK: - ArticlesUseCaseImpl
final class ArticlesUseCaseImpl: ArticlesUseCase {
    
    private let syncDataStore: SyncDataStore
    private let queryDataStore: QueryDataStore
    
    public init(syncDataStore: SyncDataStore, queryDataStore: QueryDataStore) {
        self.syncDataStore = syncDataStore
        self.queryDataStore = queryDataStore
    }
    
    func newArrivalItemsGet(page: Int) -> Single<ArticlesItemListEntity> {
        
        return syncDataStore.getItems(query: "日本語", page: page)
    }
    
    func searchItems(query: String, page: Int) -> Single<ArticlesItemListEntity> {
        
        return syncDataStore.getItems(query: query, page: page)
    }
    
    func getLikedUserList(itemID: String, likedCount: Int) -> Single<LikedUserListEntity> {
        
        return syncDataStore.getLikedUserList(itemID: itemID, likedCount: likedCount)
    }
    
    func checkLiked(itemID: String) -> Single<Response> {
        
        return syncDataStore.checkLiked(itemID: itemID)
    }
    
    func putLike(itemID: String) -> Single<Response> {
        
        return syncDataStore.putLike(itemID: itemID)
    }
    
    func deleteLike(itemID: String) -> Single<Response> {
        
        return syncDataStore.deleteLike(itemID: itemID)
    }
    
    func checkStocked(itemID: String) -> Single<Response> {
        
        return syncDataStore.checkStocked(itemID: itemID)
    }
    
    func putStock(itemID: String) -> Single<Response> {
        
        return syncDataStore.putStock(itemID: itemID)
    }
    
    func deleteStock(itemID: String) -> Single<Response> {
        
        return syncDataStore.deleteStock(itemID: itemID)
    }
    
    func getSingleItem(itemID: String) -> Single<ArticleSingleItemEntity> {
        
        return syncDataStore.getSingleItem(itemID: itemID)
    }
    
    func readTags() -> [TagDetailEntity] {
        
        let tags = queryDataStore.readAll(TagDetailEntity.self)
        return tags
    }
}
