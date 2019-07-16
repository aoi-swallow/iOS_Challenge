//
//  LikedUserEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import SwiftyJSON

// MARK: - LikedUserEntity
class LikedUserEntity {
    
    var userName: String = ""
    var userIcon: String = ""
    
    required init(json: JSON, index: Int) {
        userName = json[index]["user"]["id"].stringValue
        userIcon = json[index]["user"]["profile_image_url"].stringValue
    }
}

class LikedUserListEntity {
    
    var likedUsers: [LikedUserEntity] = []
    
    required init(json: JSON, count: Int) {
        for i in 0..<count {
            self.likedUsers.append(LikedUserEntity(json: json, index: i))
        }
    }
}
