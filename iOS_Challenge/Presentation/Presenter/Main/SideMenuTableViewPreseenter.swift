//
//  SideMenuTableViewPreseenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - SideMenuTableViewPresenter
final class SideMenuTableViewPresenter: Presenter {
    
    typealias ViewController = SideMenuTableViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: ViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var wireframe: SideMenuTableViewWireframe?
    let menuItems = ViewConst.SideMenu.items
    var syncUseCase: SyncUseCase?
    
    func tapCell(_ indexPath: IndexPath) {
        
        // TODO: Implements/
        wireframe?.dismiss(completion: {
            if indexPath.row == 0 {
                self.syncUseCase?.logout()
                    .subscribe { [weak self] result in
                        switch result {
                        case .success(_):
                            self?.wireframe?.presentLoginView()
                        case .error(let error):
                            print(error)
                        }
                }.disposed(by: self.disposeBag)
            }
        })
    }
}
