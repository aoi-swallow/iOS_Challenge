//
//  LikedUserViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - LikeUserViewBuilder
struct LikedUserViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = LikedUserViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> LikedUserViewController {
        
        let viewController = R.storyboard.articles.likedUserView()
        let presenter = LikedUserViewPresenter(viewController!)
        
        let syncDataStore: SyncDataStore = SyncDataStoreImpl()
        let queryDataStore: QueryDataStore = QueryDataStoreImpl()
        let articlesUseCase: ArticlesUseCase = ArticlesUseCaseImpl(syncDataStore: syncDataStore, queryDataStore: queryDataStore)
        presenter.articlesUseCase = articlesUseCase
        
        viewController?.presenter = presenter
        return viewController!
    }
}
