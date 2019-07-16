//
//  UserInfoViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - UserInfoViewBuilder
struct UserInfoViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = UserInfoViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> UserInfoViewController {
        
        let viewController = R.storyboard.userInfo.userInfoView()
        let presenter = UserInfoViewPresenter(viewController!)
        let wireframe = UserInfoViewWireframe(viewController!)
        presenter.wireframe = wireframe
        
        let syncDataStore: SyncDataStore = SyncDataStoreImpl()
        let queryDataStore: QueryDataStore = QueryDataStoreImpl()
        let userUseCase: UserUseCase = UserUseCaseImpl(syncDataStore: syncDataStore, queryDataStore: queryDataStore)
        presenter.userUseCase = userUseCase
        viewController?.presenter = presenter
        return viewController!
    }
}
