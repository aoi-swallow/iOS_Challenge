//
//  LoginViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//  MARK: - LoginViewController
final class LoginViewController: UIViewController {
    
    // MARK: UIViewController
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var useWithoutLoginButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter = LoginViewPresenter(self)
        
        loginButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.tapLoginButton()
            })
        .disposed(by: disposeBag)
        
        useWithoutLoginButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.tapUseWithoutLoginButton()
            })
        .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var presenter: LoginViewPresenter?
}
