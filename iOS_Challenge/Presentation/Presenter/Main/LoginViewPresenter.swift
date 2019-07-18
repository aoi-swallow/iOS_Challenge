//
//  LoginViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - LoginViewPresenter
final class LoginViewPresenter: Presenter {
    
    typealias ViewController = LoginViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: LoginViewController) {
        
        self.viewController = viewController
        wireframe = LoginViewWireframe(viewController)
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var wireframe: LoginViewWireframe?
    
    func tapLoginButton() {
        
        wireframe?.showNextView()
    }
    
    func tapUseWithoutLoginButton() {
        
        wireframe?.showMainView()
    }
}
