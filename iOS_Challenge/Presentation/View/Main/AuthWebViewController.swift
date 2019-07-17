//
//  AuthWebViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import RxCocoa
import RxSwift

// MARK: - AuthWebViewController
final class AuthWebViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var headerBar: UINavigationBar!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let webConfig = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: CGRect(x: 0, y: 60, width:self.view.bounds.size.width, height:self.view.bounds.size.height - 65), configuration: webConfig)
        wkWebView.navigationDelegate = self
        view.addSubview(wkWebView)
        view.sendSubviewToBack(wkWebView)
        
        let url = URL(string: URLConstants.authURL)
        let request = URLRequest(url: url!)
        self.wkWebView.load(request)
        
        closeButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.tapCloseButton()
            })
        .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    @objc func done() {
        print("done")
    }
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var presenter: AuthWebViewPresenter?
}

extension AuthWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
 
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let credential = URLCredential(user: "user", password: "password", persistence: URLCredential.Persistence.forSession)
        completionHandler(.useCredential, credential)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation:WKNavigation!) {
        guard let url = wkWebView.url?.absoluteURL else {
            return
        }
        
        let code = url.queryParams()["code"]
        if !code.isNil {
            UserDefaults.Keys.Auth.code.set(code!)
            self.presenter?.getAccessToken()
        }
    }
}
