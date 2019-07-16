//
//  UserOutlineCell.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import SDWebImage

class UserOutlineCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followeesLable: UILabel!
    @IBOutlet weak var followersLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconView.layer.cornerRadius = 5
        iconView.layer.masksToBounds = true
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byCharWrapping
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.white
        self.selectedBackgroundView = cellSelectedBgView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: AuthorizedUserEntity) {
        
        nameLabel.text = data.id
        userLocationLabel.text = data.location
        descriptionLabel.text = data.descriptions
        postCountLabel.text = "\(data.itemsCount) 投稿"
        followeesLable.text = "\(data.followeesCount) フォロー"
        followersLabel.text = "\(data.followersCount) フォロワー"
        iconView.sd_setImage(with: URL(string: data.profileImageUrl)) { (image, error, cache, url) in
            if error != nil {
                print(error as Any)
            }
        }
    }
}
