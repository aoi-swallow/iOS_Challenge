//
//  StockNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - StockNavBuilder
struct StockNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = StockNavigationBarController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> StockNavigationBarController {
        
        let navigationController = R.storyboard.stock.stockNav()
        let viewController = StockArticlesViewBuilder.build()
        
        navigationController?.viewControllers = []
        navigationController?.viewControllers.append(viewController)
        
        return navigationController!
    }
}
