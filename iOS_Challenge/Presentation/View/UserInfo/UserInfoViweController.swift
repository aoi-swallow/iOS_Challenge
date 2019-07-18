//
//  UserInfoViweController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

// MARK: - UserInfoViewController
final class UserInfoViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "ユーザー情報"
        self.navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
        
        let hamburgerButton = UIBarButtonItem.init(image: R.image.s_hamburger(), style: .plain, target: self, action: nil)
        hamburgerButton.rx.tap
            .subscribe { [weak self] _ in self?.presenter?.tapHamburgerButton() }
            .disposed(by: disposeBag)
        self.navigationItem.leftBarButtonItem = hamburgerButton
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        self.tableView.register(R.nib.userOutlineCell)
        self.tableView.register(R.nib.articleOutlineCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(R.nib.loadingCell)
        
        presenter?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
        .disposed(by: disposeBag)
        
        presenter?.checkAuthorized()
        
        presenter?.readUserData()
        presenter?.getUserItems()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        presenter?.readUserData()
        presenter?.getUserItems()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var presenter: UserInfoViewPresenter?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tableView.contentOffset.y + self.tableView.frame.size.height > self.tableView.contentSize.height && self.tableView.isDragging){
            self.presenter?.getUserItems()
        }
    }
}

// MARK: UITabeleViewDelegate
extension UserInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 120
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            presenter?.selectCell(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 0
        case 1:
            if presenter?.loadStatus == LoadStatus.fetching {
                return 60
            } else {
                return 0
            }
        default:
            return 0
        }
    }
}

// MARK: UITableViewDataSource
extension UserInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return presenter?.articles.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userOutlineCell, for: indexPath)
            guard let userData = presenter?.userData else {
                return cell!
            }
            cell?.setData(userData)
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleOutlineCell, for: indexPath)
            let items = presenter?.articles
            if !items!.isEmpty {
                if items?[indexPath.row].title == "" {
                    cell?.setHidden()
                } else {
                    cell?.setItem((presenter?.articles[indexPath.row])!)
                }
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "基本情報"
        case 1:
            return "投稿"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return nil
        case 1:
            if presenter?.loadStatus == LoadStatus.fetching {
                let footerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell.identifier)!
                (footerCell as! LoadingCell).startAnimation()
                let footerView: UIView = footerCell.contentView
                footerView.backgroundColor = .white
                return footerView
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}
