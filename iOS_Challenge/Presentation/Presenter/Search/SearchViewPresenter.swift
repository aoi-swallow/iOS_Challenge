//
//  SearchViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - SearchViewPresenter
final class SearchViewPresenter: Presenter {
    
    typealias ViewController = SearchViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: SearchViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var wireframe: SearchViewWireframe?
    
}
