//
//  LoginViewBuilder.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

// MARK: - LoginViewBuilder
struct LoginViewBuilder: ViewControllerBuilder {
    
    typealias ViewController = LoginViewController
    
    
    // MARK: ViewControllerBuilder
    
    static func build() -> LoginViewController {
        
        let viewController = R.storyboard.main.loginView()
        let presenter = LoginViewPresenter(viewController!)
        let wireframe = LoginViewWireframe(viewController!)
        presenter.wireframe = wireframe
        
        viewController?.presenter = presenter
        
        return viewController!
    }
}
