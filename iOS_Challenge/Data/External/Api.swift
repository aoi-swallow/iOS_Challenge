//
//  Api.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/11.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya
import RxSwift
import Result

// MARK: - Api
public final class Api {
    
    public static let shared = Api()
    private init() {}
    
    private let provider = MoyaProvider<MultiTarget>()
    
    func request<T>(_ request: T) -> Single<Response> where T: TargetType {
        
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
    }
    
    func request<T>(_ request: T, completion: @escaping Completion) where T: TargetType {
        
        let target = MultiTarget(request)
        provider.request(target, completion: completion)
    }
}
