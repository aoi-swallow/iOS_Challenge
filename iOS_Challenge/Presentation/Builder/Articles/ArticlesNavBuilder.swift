//
//  ArticlesNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - ArticleNavBuilder
struct ArticleNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = ArticlesNavigationController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> ArticlesNavigationController {
        
        let navigationController = R.storyboard.articles.articlesNav()
        let viewController = ArticlesListViewBuilder.build()
        
        navigationController?.viewControllers = []
        navigationController?.viewControllers.append(viewController)
        
        return navigationController!
    }
}
