//
//  SearchViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SearchViewWireframe
struct SearchViewWireframe: Wireframe {
    
    typealias ViewController = SearchViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: SearchViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal

}
