//
//  SearchNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SearchNavBuilder
struct SearchNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = SearchNavigationBarController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> SearchNavigationBarController {
        
        let navigationController = R.storyboard.search.searchNav()
        let viewController = SearchViewBuilder.build()
        
        navigationController?.viewControllers = []
        navigationController?.viewControllers.append(viewController)
        
        return navigationController!
    }
}
