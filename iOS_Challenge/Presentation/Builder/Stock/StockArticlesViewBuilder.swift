//
//  StockArticlesViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: StockArticlesViewBuilder
struct StockArticlesViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = StockArticlesViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> StockArticlesViewController {
        
        let viewController = R.storyboard.stock.stockArticlesView()
        let presenter = StockArticlesViewPresenter(viewController!)
        let wireframe = StockArticlesViewWireframe(viewController!)
        
        let syncDaraStore: SyncDataStore = SyncDataStoreImpl()
        let queryDataStore: QueryDataStore = QueryDataStoreImpl()
        let articlesUseCase: ArticlesUseCase = ArticlesUseCaseImpl(syncDataStore: syncDaraStore, queryDataStore: queryDataStore)
        presenter.articlesUseCase = articlesUseCase
        presenter.wireframe = wireframe
        
        viewController?.presenter = presenter
        return viewController!
    }
}
