//
//  StockArticlesViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/17.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

// MARK: - StockArticlesViewController
final class StockArticlesViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "ストック"
        self.navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
        
        self.tableView.register(R.nib.articleOutlineCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 120
        self.tableView.register(R.nib.loadingCell)
        let footerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell.identifier)!
        (footerCell as! LoadingCell).startAnimation()
        let footerView: UIView = footerCell.contentView
        tableView.tableFooterView = footerView
        
        presenter?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        presenter?.alertToggle.asSignal()
            .emit(onNext: { [weak self] (title, message) in
                self?.showAlert(title: title, message: message)
            })
            .disposed(by: disposeBag)
        
        presenter?.getData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    private func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Internal
    
    var presenter: StockArticlesViewPresenter?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tableView.contentOffset.y + self.tableView.frame.size.height > self.tableView.contentSize.height && self.tableView.isDragging){
            self.presenter?.getData()
        }
    }
}

// MARK: UITableViewDelegate
extension StockArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.selectCell(index: indexPath.row)
    }
}

// MARK: UITableViewDataStore
extension StockArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleOutlineCell, for: indexPath)
        if (presenter?.articles.isEmpty)! {
            return cell!
        } else {
            cell?.setItem((presenter?.articles[indexPath.row])!)
            return cell!
        }
    }
}
