//
//  UserInfoViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - UserInfoViewWireframe
struct UserInfoViewWireframe: Wireframe {
    
    typealias ViewController = UserInfoViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: UserInfoViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
}
