//
//  ArticleDetailViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import MarkdownView
import RxCocoa
import RxSwift
import SDWebImage

// MARK: - ArticleDetailViewController
final class ArticleDetailViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var markdownView: MarkdownView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var goodCountLabel: UILabel!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var stockButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        markdownView.load(markdown: presenter?.selectedItem?.body)
        markdownView.isScrollEnabled = true
        
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byCharWrapping
        titleLabel.text = presenter?.selectedItem?.title
        userNameLabel.text = presenter?.selectedItem?.userName
        iconImage.layer.cornerRadius = 5
        iconImage.layer.masksToBounds = true
        iconImage.sd_setImage(with: URL(string: (presenter?.selectedItem?.userIconUrl)!)) { (image, error, cache, url) in
            if error != nil { print(error as Any) }
        }
        let date = presenter?.selectedItem!.updatedAt.components(separatedBy: "T")[0]
        dateLabel.text = date
        goodCountLabel.text = "いいね \(String(describing: (presenter?.likesCount)!))"
        goodCountLabel.layer.cornerRadius = 5
        goodCountLabel.layer.masksToBounds = true
        let tap = UITapGestureRecognizer()
        tap.rx.event.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.presenter?.tapGoodCountLabel()
            })
        .disposed(by: disposeBag)
        goodCountLabel.addGestureRecognizer(tap)
        
        presenter?.checkLiked()
        presenter?.checkStocked()
        
        goodButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.tapGoodButton()
            })
        .disposed(by: disposeBag)
        
        stockButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.tapStockButton()
            })
        .disposed(by: disposeBag)
        
        presenter?.likeIconToggle.asDriver()
            .drive(onNext: { [weak self] isLiked in
                if isLiked {
                    self?.goodButton.setImage(R.image.liked_check(), for: .normal)
                } else {
                    self?.goodButton.setImage(R.image.good_green(), for: .normal)
                }
            })
        .disposed(by: disposeBag)
        
        presenter?.stockIconToggle.asDriver()
            .drive(onNext: { [weak self] isStocked in
                if isStocked {
                    self?.stockButton.setImage(R.image.stocked_check(), for: .normal)
                } else {
                    self?.stockButton.setImage(R.image.stock_green(), for: .normal)
                }
            })
        .disposed(by: disposeBag)
        
        presenter?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.goodCountLabel.text = "いいね \(String(describing: (self?.presenter?.likesCount)!))"
            })
        .disposed(by: disposeBag)
        
        presenter?.alertToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.showLoginAlert()
            })
        .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    private func showLoginAlert() {
        
        let alertController = UIAlertController(title: "ログインが必要です",
                                                message: "この動作はQiitaアカウントでのログイン認証が必要です",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ログインする", style: .default) { (action: UIAlertAction) in
            self.presenter?.tapLoginButton()
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Internal
    
    var presenter: ArticleDetailViewPresenter?
}
