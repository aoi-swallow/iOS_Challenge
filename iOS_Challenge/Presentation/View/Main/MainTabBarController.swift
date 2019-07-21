//
//  MainTabBarController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// MARK: - MainTabBarController
final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Internal
    
    var presenter: MainTabBarPresenter?
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if UserDefaults.Keys.State.isLogin.value() {
            return true
        } else {
            if viewController is StockNavigationBarController || viewController is UserInfoNavigationBarController {
                presenter?.tapTab()
                return false
            }
            return true
        }
    }
}
