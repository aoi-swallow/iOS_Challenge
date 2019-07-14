//
//  UserInfoNavBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - UserInfoNavBuilder
struct UserInfoNavBuilder: ViewControllerBuilder {
    
    typealias ViewController = UserInfoNavigationBarController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> UserInfoNavigationBarController {
        
        let navigationController = R.storyboard.userInfo.userInfoNav()
        
        navigationController?.viewControllers = []
        
        return navigationController!
    }
}
