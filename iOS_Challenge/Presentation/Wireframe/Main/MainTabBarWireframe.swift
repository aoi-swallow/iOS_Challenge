//
//  MainTabBarWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - MainTabBarController
struct MainTabBarWireframe: Wireframe {
    
    typealias ViewController = MainTabBarController
    
    
    // MARK: Wireframe
    
    init(_ viewController: MainTabBarController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
}
