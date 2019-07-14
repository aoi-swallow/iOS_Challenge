//
//  MainTabBarBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - MainTabBarBuilder
struct MainTabBarBuilder: ViewControllerBuilder {
    
    
    typealias ViewController = MainTabBarController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> MainTabBarController {
        
        let tabBarController = R.storyboard.main.mainTabBar()
        
        let presenter = MainTabBarPresenter(tabBarController!)
        presenter.wireframe = MainTabBarWireframe(tabBarController!)
        
        tabBarController?.presenter = presenter
        
        var viewControllers: [UIViewController] = []
        viewControllers.append(ArticleNavBuilder.build())
        viewControllers.append(SearchNavBuilder.build())
        viewControllers.append(StockNavBuilder.build())
        viewControllers.append(UserInfoNavBuilder.build())
        
        tabBarController?.setViewControllers(viewControllers, animated: false)
        return tabBarController!
    }
    
  
    
}
