//
//  ArticleOutlineCell.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleOutlineCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byCharWrapping
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.white
        self.selectedBackgroundView = cellSelectedBgView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(_ item: ArticlesItemEntity) {
        
        let date = item.updatedAt.components(separatedBy: "T")[0]
        userNameLabel.text = item.userName
        dateLabel.text = date
        titleLabel.text = item.title
        tagLabel.text = item.tags.joined(separator: ", ")
        iconImageView.sd_setImage(with: URL(string: item.userIconUrl)) { (image, error, cache, url) in
            if error != nil {
                print(error)
            }
        }
    }
    
}
