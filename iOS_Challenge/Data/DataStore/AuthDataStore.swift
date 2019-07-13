//
//  AuthDataStore.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import KeychainAccess
import Moya
import RxSwift

// MARK: - AuthDataStore
protocol AuthDataStore {
    func getAccessToken() -> Single<Void>
}

// MARK: - AuthDataStoreImpl
final class AuthDataStoreImpl: AuthDataStore {
    
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    func getAccessToken() -> Single<Void> {
        
        let task = Api.shared.request(ApiService.IssueAcceessToken())
        return task.flatMap { [weak self] response in
            return Single.create { observer in
                var resp: AccessTokenResponse?
                do {
                    resp = try JSONDecoder().decode(AccessTokenResponse.self, from: response.data)
                } catch {
                    observer(.error(error))
                    return Disposables.create()
                }
                self?.keychain[AppKey.Keychain.token.rawValue] = resp?.token
                print("Login Success")
                observer(.success(()))
                return Disposables.create()
            }
        }
    }
}

