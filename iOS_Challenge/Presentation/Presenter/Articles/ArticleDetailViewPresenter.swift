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
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var wireframe: ArticleDetailViewWireframe?
    var articlesUseCase: ArticlesUseCase?
    var selectedItem: ArticlesItemEntity?
    var itemID: String = ""
    var likesCount: Int = 0
    var isLiked: Bool = false
    var isStocked: Bool = false
    private(set) var likeIconToggle = BehaviorRelay<Bool>(value: false)
    private(set) var stockIconToggle = BehaviorRelay<Bool>(value: false)
    private(set) var refreshToggle = PublishRelay<Void>()
    
    private func refreshArticleData() {
        
        articlesUseCase?.getSingleItem(itemID: self.itemID)
            .subscribe { [weak self] result in
                switch result {
                case .success(let item):
                    self?.likesCount = item.likesCount
                    self?.refreshToggle.accept(())
                case .error(let error):
                    print(error)
                }
        }.disposed(by: disposeBag)
    }
    
    func checkLiked() {
        
        articlesUseCase?.checkLiked(itemID: self.itemID)
            .subscribe { [weak self] result in
                switch result {
                case .success(_):
                    self?.isLiked = true
                    self?.likeIconToggle.accept(true)
                case .error(_):
                    self?.isLiked = false
                    self?.likeIconToggle.accept(false)
                }
            }.disposed(by: disposeBag)
    }
    
    func checkStocked() {
        
        articlesUseCase?.checkStocked(itemID: self.itemID)
            .subscribe { [weak self] result in
                switch result {
                case .success(_):
                    self?.isStocked = true
                    self?.stockIconToggle.accept(true)
                case .error(_):
                    self?.isStocked = false
                    self?.stockIconToggle.accept(false)
                }
        }.disposed(by: disposeBag)
    }
    
    func tapGoodCountLabel() {
        
        wireframe?.showLikedUserList(itemID: selectedItem!.id, likedCount: self.likesCount )
    }
    
    func tapGoodButton() {
        
        if isLiked {
            articlesUseCase?.deleteLike(itemID: itemID)
                .subscribe { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.isLiked = false
                        self?.refreshArticleData()
                        self?.likeIconToggle.accept(false)
                    case .error(let error):
                        print(error)
                    }
            }.disposed(by: disposeBag)
        } else {
            articlesUseCase?.putLike(itemID: itemID)
                .subscribe { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.isLiked = true
                        self?.refreshArticleData()
                        self?.likeIconToggle.accept(true)
                    case .error(let error):
                        print(error)
                        
                    }
            }.disposed(by: disposeBag)
        }
    }
    
    func tapStockButton() {
        
        if isStocked {
            articlesUseCase?.deleteStock(itemID: itemID)
                .subscribe { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.isStocked = false
                        self?.stockIconToggle.accept(false)
                    case .error(let error):
                        print(error)
                    }
            }.disposed(by: disposeBag)
        } else {
            articlesUseCase?.putStock(itemID: itemID)
                .subscribe { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.isStocked = true
                        self?.stockIconToggle.accept(true)
                    case .error(let error):
                        print(error)
                    }
            }.disposed(by: disposeBag)
        }
    }
}
