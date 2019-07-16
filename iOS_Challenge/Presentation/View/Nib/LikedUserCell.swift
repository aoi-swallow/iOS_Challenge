//
//  LikedUserCell.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

class LikedUserCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(_ item: LikedUserEntity) {
        
        userNameLabel.text = item.userName
        iconImageView.sd_setImage(with: URL(string: item.userIcon)) { (image, error, cache, url) in
            if error != nil {
                print(error as Any)
            }
        }
    }
    
}
