//
//  SearchViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SearchViewBuilder
struct SearchViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = SearchViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> SearchViewController {
        
        let viewController = R.storyboard.search.searchView()
        let presenter = SearchViewPresenter(viewController!)
        let wireframe = SearchViewWireframe(viewController!)
        presenter.wireframe = wireframe
        
        let syncDataStore: SyncDataStore = SyncDataStoreImpl()
        let queryDataStore: QueryDataStore = QueryDataStoreImpl()
        let articlesUseCase: ArticlesUseCase = ArticlesUseCaseImpl(syncDataStore: syncDataStore, queryDataStore: queryDataStore)
        presenter.articlesUseCase = articlesUseCase
        viewController?.presenter = presenter
        return viewController!
    }
}
