//
//  LikedUserViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - LikedUserViewPresenter
final class LikedUserViewPresenter: Presenter {
    
    typealias ViewController = LikedUserViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: LikedUserViewController) {
        
        self.viewController = viewController
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var articlesUseCase: ArticlesUseCase?
    var likedCount: Int = 0
    var itemID: String = ""
    var likedUsers: [LikedUserEntity] = []
    private(set) var hudToggle = PublishRelay<Bool>()
    private(set) var refreshToggle = PublishRelay<Void>()
    private(set) var alertToggle = PublishRelay<(String, String)>()
    
    func getLikedUserList() {
        
        hudToggle.accept(true)
        articlesUseCase?.getLikedUserList(itemID: itemID, likedCount: likedCount)
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    self?.likedUsers = data.likedUsers
                    self?.refreshToggle.accept(())
                    self?.hudToggle.accept(false)
                case .error(let error):
                    print(error)
                    self?.hudToggle.accept(false)
                    self?.alertToggle.accept(("エラー", "データを取得できませんでした"))
                }
            }
        .disposed(by: disposeBag)
    }
}
