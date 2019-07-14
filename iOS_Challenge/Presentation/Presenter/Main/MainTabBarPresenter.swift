//
//  MainTabBarPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - MainTabBarPresenter
final class MainTabBarPresenter: Presenter {
    
    typealias ViewController = MainTabBarController
    
    init(_ viewController: MainTabBarController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var wireframe: MainTabBarWireframe?
    
}
