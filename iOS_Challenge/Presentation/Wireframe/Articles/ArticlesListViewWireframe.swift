//
//  ArticlesListViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - ArticleListViewWireframe
struct ArticleListViewWireframe: Wireframe {
    
    typealias ViewController = ArticlesListViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: ArticlesListViewController) {
        
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
}
