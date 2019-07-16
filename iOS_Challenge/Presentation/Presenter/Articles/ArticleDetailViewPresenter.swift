//
//  ArticleDetailViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - ArticleDetailViewPresenter
final class ArticleDetailViewPresenter: Presenter {
    
    typealias ViewController = ArticleDetailViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: ArticleDetailViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var wireframe: ArticleDetailViewWireframe?
    var selectedItem: ArticlesItemEntity?
    
    func tapGoodCountLabel() {
        
        wireframe?.showLikedUserList(itemID: selectedItem!.id, likedCount: selectedItem?.likesCount ?? 0)
    }
    
    func tapGoodButton() {
        
    }
    
    func tapStockButton() {
        
    }
}
