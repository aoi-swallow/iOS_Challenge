//
//  StockArticlesViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - StockArticlesViewPresenter
final class StockArticlesViewPresenter: Presenter {
    
    typealias ViewController = StockArticlesViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: StockArticlesViewController) {
        
        self.viewController = viewController
        loadStatus = .initial
        page = 1
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var wireframe: StockArticlesViewWireframe?
    var articlesUseCase: ArticlesUseCase?
    var articles: [ArticlesItemEntity] = []
    var page: Int = 1
    var loadStatus: LoadStatus?
    private(set) var refreshToggle = PublishRelay<Void>()
    private(set) var alertToggle = PublishRelay<(String, String)>()
    
    func getData() {
        
        guard loadStatus == .initial else {
            return
        }
        self.loadStatus = .fetching
        self.refreshToggle.accept(())
        self.articlesUseCase?.getStockedItems(page: page)
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    var contents: [ArticlesItemEntity] = []
                    for item in data.articles {
                        if item.id != "" {
                            contents.append(item)
                        }
                    }
                    if contents.count == 10 {
                        self?.articles.append(contentsOf: contents)
                        self?.page += 1
                        self?.loadStatus = .initial
                        self?.refreshToggle.accept(())
                    } else {
                        self?.articles.append(contentsOf: contents)
                        self?.loadStatus = .full
                        self?.refreshToggle.accept(())
                    }
                case .error(let error):
                    print(error)
                    self?.alertToggle.accept(("Error", "データを取得できませんでした"))
                    self?.loadStatus = .initial
                    self?.refreshToggle.accept(())
                }
            }
            .disposed(by: disposeBag)
    }
    
    func selectCell(index: Int) {
        
        wireframe?.showDetailView(articles[index])
    }
}

