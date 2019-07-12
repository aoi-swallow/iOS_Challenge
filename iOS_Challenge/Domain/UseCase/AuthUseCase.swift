//
//  AuthUseCase.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya
import RxSwift

// MARK: - AuthUseCase
protocol AuthUseCase {
  func getAccessToken() -> Single<Void>
}

// MARK: - AuthUseCaseImpl
final class AuthUseCaseImpl: AuthUseCase {
    
    private let authDataStore: AuthDataStore
    
    public init(_ authDataStore: AuthDataStore) {
        
        self.authDataStore = authDataStore
    }
    
    func getAccessToken() -> Single<Void> {
        
        return authDataStore.getAccessToken()
    }
}

