//
//  ArticleDetailViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - ArticlesDetailViewWireframe
struct ArticleDetailViewWireframe: Wireframe {
    
    typealias ViewController = ArticleDetailViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: ArticleDetailViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    func showLikedUserList(itemID: String, likedCount: Int) {
        
        let nextViewController = LikedUserViewBuilder.build()
        nextViewController.presenter?.itemID = itemID
        nextViewController.presenter?.likedCount = likedCount
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func showAuthWebView() {
        
        let nextViewController = AuthNavBuilder.build()
        self.viewController?.present(nextViewController, animated: true, completion: nil)
    }
}
