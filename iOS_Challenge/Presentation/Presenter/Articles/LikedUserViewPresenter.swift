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
        loadStatus = .initial
        page = 1
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var articlesUseCase: ArticlesUseCase?
    var likedCount: Int = 0
    var itemID: String = ""
    var page: Int = 1
    var loadStatus: LoadStatus?
    var likedUsers: [LikedUserEntity] = []
    private(set) var hudToggle = PublishRelay<Bool>()
    private(set) var refreshToggle = PublishRelay<Void>()
    private(set) var alertToggle = PublishRelay<(String, String)>()
    
    func getLikedUserList() {
        
        guard loadStatus == .initial else {
            return
        }
        self.loadStatus = .fetching
        self.articlesUseCase?.getLikedUserList(itemID: itemID, page: page)
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    var contents: [LikedUserEntity] = []
                    for item in data.likedUsers {
                        if item.userName != "" {
                            contents.append(item)
                        }
                    }
                    if !contents.isEmpty {
                        self?.likedUsers.append(contentsOf: contents)
                        self?.refreshToggle.accept(())
                        self?.page += 1
                        self?.loadStatus = .initial
                    } else {
                        self?.loadStatus = .full
                    }
                case .error(let error):
                    print(error)
                    self?.alertToggle.accept(("Error", "データを取得できませんでした"))
                    self?.loadStatus = .initial
                }
            }
            .disposed(by: disposeBag)
    }
}
