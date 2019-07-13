//
//  LoginViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

// MARK: - LoginViewWireframe
struct LoginViewWireframe: Wireframe {
    
    typealias ViewController = LoginViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: LoginViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    func showAuthWebView() {
        
        let nextViewController = AuthWebViewBuilder.build()
        self.viewController?.present(nextViewController, animated: true, completion: nil)
    }
    
    func showMainView() {
        
    }
}
