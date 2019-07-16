//
//  LikedUserViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import RxCocoa
import RxSwift

// MARK: - LikedUserViewController
final class LikedUserViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.register(R.nib.likedUserCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        presenter?.getLikedUserList()
        
        presenter?.hudToggle.asSignal()
            .emit(onNext: { [weak self] show in
                if show {
                    self?.hud.show(in: self!.view)
                } else {
                    self?.hud.dismiss()
                }
            })
        .disposed(by: disposeBag)
        
        presenter?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
        .disposed(by: disposeBag)
        
        presenter?.alertToggle.asSignal()
            .emit(onNext: { [weak self] (title, message) in
                self?.showalert(title: title, message: message)
            })
        .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    private let hud = JGProgressHUD(style: .light)
    
    private func showalert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Internal
    
    var presenter: LikedUserViewPresenter?
    
}

// MARK: UITableViewDelegate
extension LikedUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
}

// MARK: UITabelViewDataSource
extension LikedUserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.likedUsers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.likedUserCell, for: indexPath)
        if !(presenter?.likedUsers.isEmpty)! {
         cell?.setItem((presenter?.likedUsers[indexPath.row])!)
        }
        return cell!
    }
}
