//
//  UserUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxSwift

// MARK: - UserUseCase
protocol UserUseCase {
    func getAuthorizedUserItems(page: Int) -> Single<ArticlesItemListEntity>
    func readAuthorizedUserData() -> AuthorizedUserEntity?
}

// MARK: - AuthUseCaseImpl
final class UserUseCaseImpl: UserUseCase {
    
    private let syncDataStore: SyncDataStore
    private let queryDataStore: QueryDataStore
    
    public init(syncDataStore: SyncDataStore, queryDataStore: QueryDataStore) {
        
        self.syncDataStore = syncDataStore
        self.queryDataStore = queryDataStore
    }
    
    func getAuthorizedUserItems(page: Int) -> Single<ArticlesItemListEntity> {
        
        return syncDataStore.getAuthorizedUsersItems(page: page)
    }
    
    func readAuthorizedUserData() -> AuthorizedUserEntity? {
       
        let user = queryDataStore.readAll(AuthorizedUserEntity.self)
        return user.first
    }
}
