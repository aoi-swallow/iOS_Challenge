//
//  AuthWebViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - AuthWebViewPresenter
final class AuthWebViewPresenter: Presenter {
    
    typealias ViewController = AuthWebViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: AuthWebViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Presenter
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var wireframe: AuthWebViewWireframe?
    var authUseCase: AuthUseCase?
    var syncUseCase: SyncUseCase?
    
    func getAccessToken() {
        
        authUseCase?.getAccessToken()
            .flatMap { _ in (self.syncUseCase?.getLaunchData())!}
            .subscribe { [weak self] result in
                switch result {
                case .success(_):
                    self?.wireframe?.showMainView()
                case .error(let error):
                    print(error)
                }
        }.disposed(by: disposeBag)
    }
    
    func tapCloseButton() {
        
        wireframe?.dismiss()
    }
}
