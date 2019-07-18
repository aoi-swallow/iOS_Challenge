//
//  SideMenuTableViewWireframe.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SideMenuTableViewWireframe
struct SideMenuTableViewWireframe: Wireframe {
    
    typealias ViewController = SideMenuTableViewController
    
    
    // MARK: Wireframe
    
    init(_ viewController: ViewController) {
        
        self.viewController = viewController
    }
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    func dismiss(completion: @escaping () -> Void) {
        
        viewController?.dismiss(animated: false, completion: completion)
    }
    
    func presentLoginView() {
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        let loginViewContoller = LoginViewBuilder.build()
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = loginViewContoller
        appDelegate.window?.makeKeyAndVisible()
    }
}

