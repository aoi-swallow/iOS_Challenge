//
//  ArticlesListViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: ArticlesListViewBuilder
struct ArticlesListViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = ArticlesListViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> ArticlesListViewController {
        
        let viewController = R.storyboard.articles.articlesListView()
        let presenter = ArticlesListViewPresenter(viewController!)
        let wireframe = ArticleListViewWireframe(viewController!)
        
        let syncDaraStore: SyncDataStore = SyncDataStoreImpl()
        let articlesUseCase: ArticlesUseCase = ArticlesUseCaseImpl(syncDaraStore)
        presenter.articlesUseCase = articlesUseCase
        presenter.wireframe = wireframe
        
        viewController?.presenter = presenter
        return viewController!
    }
}
