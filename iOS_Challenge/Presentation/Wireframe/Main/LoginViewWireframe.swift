//
//  LoginViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//
import Foundation

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
    
    func showNextView() {
        
        let isLogin = UserDefaults.Keys.State.isLogin.value()
        if isLogin {
            self.showMainView()
        } else {
            self.showAuthWebView()
        }
    }
    
    private func showAuthWebView() {
        
        let nextViewController = AuthNavBuilder.build()
        self.viewController?.present(nextViewController, animated: true, completion: nil)
    }
    
    func showMainView() {
        
        let nextViewController = MainTabBarBuilder.build()
        self.viewController?.present(nextViewController, animated: true, completion: nil)
    }
}
