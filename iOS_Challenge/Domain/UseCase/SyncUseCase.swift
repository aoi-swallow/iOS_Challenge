//
//  SyncUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxSwift

// MARK: - SyncUseCase
protocol SyncUseCase {
    func getLaunchData() -> Single<Void>
}

// MARK: - SyncUseCaseImpl
final class SyncUseCaseImpl: SyncUseCase {
    
    private let syncDataStore: SyncDataStore
    
    public init(_ syncDataStore: SyncDataStore) {
        
        self.syncDataStore = syncDataStore
    }
    
    func getLaunchData() -> Single<Void> {
        
        let task = syncDataStore.getAuthorizedUserInfo()
        return task.flatMap { [unowned self] _ in self.syncDataStore.getStockedItems()}
    }
}
