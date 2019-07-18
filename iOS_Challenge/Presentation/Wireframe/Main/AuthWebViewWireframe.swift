//
//  AuthWebViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//
import UIKit

// MARK: - AuthWebViewWireframe
struct AuthWebViewWireframe: Wireframe {
    
    typealias ViewController = AuthWebViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: AuthWebViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    func showMainView() {
        
        self.viewController?.dismiss(animated: true, completion: {
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController as! LoginViewController
            rootViewController.presenter?.wireframe?.showNextView()
        })
    }
    
    func dismiss() {
        
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
