//
//  SyncUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxSwift
import KeychainAccess

// MARK: - SyncUseCase
protocol SyncUseCase {
    func getLaunchData() -> Single<Void>
    func logout() -> Single<Void>
}

// MARK: - SyncUseCaseImpl
final class SyncUseCaseImpl: SyncUseCase {
    
    private let syncDataStore: SyncDataStore
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    public init(_ syncDataStore: SyncDataStore) {
        
        self.syncDataStore = syncDataStore
    }
    
    func getLaunchData() -> Single<Void> {
        
        let task = syncDataStore.getAuthorizedUserInfo()
        return task
    }
    
    func logout() -> Single<Void> {
        UserDefaults.Keys.State.isLogin.set(false)
        UserDefaults.Keys.Auth.userID.set("")
        self.keychain[AppKey.Keychain.token.rawValue] = nil
        
        return syncDataStore.deleteData()
    }
}
