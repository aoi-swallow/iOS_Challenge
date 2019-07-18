//
//  SideMenuTableViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SideMenuTableViewBuilder
struct SideMenuTableViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = SideMenuTableViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> ViewController {
        
        let viewController = R.storyboard.main.sideMenuTableView()
        let presenter = SideMenuTableViewPresenter(viewController!)
        presenter.wireframe = SideMenuTableViewWireframe(viewController!)
        let syncDataStore: SyncDataStore = SyncDataStoreImpl()
        let syncUseCase: SyncUseCase = SyncUseCaseImpl(syncDataStore)
        
        presenter.syncUseCase = syncUseCase
        viewController?.presenter = presenter
        return viewController!
    }
}
