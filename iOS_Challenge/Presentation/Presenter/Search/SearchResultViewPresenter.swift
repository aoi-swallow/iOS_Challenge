//
//  SearchResultViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - SearchResultViewPresenter
final class SearchResultViewPresenter: Presenter {
    
    typealias ViewController = SearchResultViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: SearchResultViewController) {
        
        self.viewController = viewController
        loadStatus = .initial
        page = 1
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var wireframe: SearchResultViewWireframe?
    var articlesUseCase: ArticlesUseCase?
    var query: String = ""
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
        self.articlesUseCase?.searchItems(query: query, page: self.page)
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    var contents: [ArticlesItemEntity] = []
                    for item in data.articles {
                        if item.id != "" {
                            contents.append(item)
                        }
                    }
                    if !contents.isEmpty {
                        self?.articles.append(contentsOf: contents)
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
    
    func selectCell(index: Int) {
        
        wireframe?.showDetailView(articles[index])
    }
   
}
