//
//  StockArticlesViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - StockArticlesViewWireframe
struct StockArticlesViewWireframe: Wireframe {
    
    typealias ViewController = StockArticlesViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: StockArticlesViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    func showDetailView(_ item: ArticlesItemEntity) {
        
        let nextViewController = ArticleDetailViewBuilder.build()
        nextViewController.presenter?.selectedItem = item
        nextViewController.presenter?.itemID = item.id
        nextViewController.presenter?.likesCount = item.likesCount
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func showAuthWebView() {
        
        let nextViewController = AuthNavBuilder.build()
        self.viewController?.present(nextViewController, animated: true, completion: nil)
    }
}
