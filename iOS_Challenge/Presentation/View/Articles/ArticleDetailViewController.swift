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
        goodCountLabel.text = "いいね \(String(describing: (presenter?.selectedItem?.likesCount)!))"
        goodCountLabel.layer.cornerRadius = 5
        goodCountLabel.layer.masksToBounds = true
        let tap = UITapGestureRecognizer()
        tap.rx.event.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.presenter?.tapGoodCountLabel()
            })
        .disposed(by: disposeBag)
        goodCountLabel.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var presenter: ArticleDetailViewPresenter?
}
