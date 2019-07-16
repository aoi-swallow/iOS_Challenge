//
//  SearchResultViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: SearchResultViewBuilder
struct SearchResultViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = SearchResultViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> SearchResultViewController {
        
        let viewController = R.storyboard.search.searchResultView()
        let presenter = SearchResultViewPresenter(viewController!)
        let wireframe = SearchResultViewWireframe(viewController!)
        
        let syncDaraStore: SyncDataStore = SyncDataStoreImpl()
        let queryDataStore: QueryDataStore = QueryDataStoreImpl()
        let articlesUseCase: ArticlesUseCase = ArticlesUseCaseImpl(syncDataStore: syncDaraStore, queryDataStore: queryDataStore)
        presenter.articlesUseCase = articlesUseCase
        presenter.wireframe = wireframe
        
        viewController?.presenter = presenter
        return viewController!
    }
}
