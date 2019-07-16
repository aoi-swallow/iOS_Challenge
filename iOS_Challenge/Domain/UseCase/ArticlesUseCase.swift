//
//  ArticlesUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxSwift

// MARK: - SyncUseCase
protocol ArticlesUseCase {
    func newArrivalItemsGet(page: Int) -> Single<ArticlesItemListEntity>
    func searchItems(query: String, page: Int) -> Single<ArticlesItemListEntity>
    func getLikedUserList(itemID: String, likedCount: Int) -> Single<LikedUserListEntity>
}

// MARK: - ArticlesUseCaseImpl
final class ArticlesUseCaseImpl: ArticlesUseCase {
    
    private let syncDataStore: SyncDataStore
    
    public init(_ syncDataStore: SyncDataStore) {
        self.syncDataStore = syncDataStore
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
}
