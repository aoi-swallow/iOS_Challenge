//
//  ArticlesNavigationController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - ArticlesNavigationController
final class ArticlesNavigationController: UINavigationController {
    
    
    // MARK: UINavigationController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.IconColor.defaultGreen
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
