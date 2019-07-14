//
//  AuthNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SearchNavBuilder
struct AuthNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = AuthNavigationBarController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> AuthNavigationBarController {
        
        let navigationController = R.storyboard.main.authNav()
//        let viewController = R.storyboard.main.authWebView()
        
        navigationController?.viewControllers = []
//        navigationController?.viewControllers.append(viewController!)
        
        return navigationController!
    }
}
