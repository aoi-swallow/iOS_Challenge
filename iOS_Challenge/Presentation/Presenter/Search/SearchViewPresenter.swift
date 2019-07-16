//
//  SearchViewPresenter.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - SearchViewPresenter
final class SearchViewPresenter: Presenter {
    
    typealias ViewController = SearchViewController
    
    
    // MARK: Presenter
    
    init(_ viewController: SearchViewController) {
        
        self.viewController = viewController
        getHistories()
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    
    
    // MARK: Internal
    
    var wireframe: SearchViewWireframe?
    var articlesUseCase: ArticlesUseCase?
    var historis: [String] = []
    private(set) var refrashToggle = PublishRelay<Void>()
    
    func getHistories() {
        
        self.historis = UserDefaults.Keys.Search.histories.value().reversed()
        refrashToggle.accept(())
    }
    
    func tapSearchButton(query: String) {
        
        var background = UserDefaults.Keys.Search.histories.value()
        if background.contains(query) {
            let num = background.firstIndex(of: query)
            background.remove(at: num!)
            background.append(query)
        } else {
            if background.count >= 10 {
                background.removeFirst()
            }
            background.append(query)
        }
        UserDefaults.Keys.Search.histories.set(background)
        wireframe?.showResultView(query: query)
    }
  
    func selectHistory(index: Int) {
        
        let query = historis[index]
        var background = UserDefaults.Keys.Search.histories.value()
        let num = background.firstIndex(of: query)
        background.remove(at: num!)
        background.append(query)
        UserDefaults.Keys.Search.histories.set(background)
        wireframe?.showResultView(query: query)
    }
    
    func deleteHistory(index: Int) {
        
        let query = historis[index]
        var background = UserDefaults.Keys.Search.histories.value()
        let deleteNum = background.firstIndex(of: query)
        background.remove(at: deleteNum!)
        UserDefaults.Keys.Search.histories.set(background)
        getHistories()
    }
}
