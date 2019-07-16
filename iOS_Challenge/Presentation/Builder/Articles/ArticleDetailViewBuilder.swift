//
//  ArticleDetailViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - ArticleDetailViewBuilder
struct ArticleDetailViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = ArticleDetailViewController
    
    
    // MARK: Presenter
    
    static func build() -> ArticleDetailViewController {
        
        let viewController = R.storyboard.articles.articleDetailView()
        let presenter = ArticleDetailViewPresenter(viewController!)
        let wireframe = ArticleDetailViewWireframe(viewController!)
        
        presenter.wireframe = wireframe
        
        viewController?.presenter = presenter
        return viewController!
    }
    
    
}
