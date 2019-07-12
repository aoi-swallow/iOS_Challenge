//
//  AuthWebViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

// MARK: - AuthWebViewBuilder
struct AuthWebViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = AuthWebViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> AuthWebViewController {
        
        let viewController = R.storyboard.main.authWebView()
        let presenter = AuthWebViewPresenter(viewController!)
        let wireframe = AuthWebViewWireframe(viewController!)
        presenter.wireframe = wireframe
        
        let dataStore: AuthDataStore = AuthDataStoreImpl()
        let authUseCase: AuthUseCase = AuthUseCaseImpl(dataStore)
        presenter.authUseCase = authUseCase
        viewController?.presenter = presenter
        
        return viewController!
    }
}
