//
//  SideMenuTableViewNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import SideMenu

// MARK: - SideMenuTableViewNavBuilder
struct SideMenuTableViewNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = UISideMenuNavigationController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> ViewController {
        
        let viewController = R.storyboard.main.sideMenuNav()
        viewController?.viewControllers = []
        viewController?.viewControllers.append(SideMenuTableViewBuilder.build())
        return viewController!
    }
}
