//
//  ArticlesItemEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import SwiftyJSON

// MARK: - ArticlesItemEntity
class ArticlesItemEntity {
    
    var title: String = ""
    var id: String = ""
    var updatedAt: String = ""
    var likesCount: Int = 0
    var body: String = ""
    var tags: [String] = []
    var userName: String = ""
    var userIconUrl: String = ""
    
    required init(json: JSON, index: Int) {
        title = json[index]["title"].stringValue
        id = json[index]["id"].stringValue
        updatedAt = json[index]["updated_at"].stringValue
        likesCount = json[index]["likes_count"].intValue
        body = json[index]["body"].stringValue
        let tagArray = json[index]["tags"].arrayValue
        for tag in tagArray {
            self.tags.append(tag["name"].stringValue)
        }
        userName = json[index]["user"]["id"].stringValue
        userIconUrl = json[index]["user"]["profile_image_url"].stringValue
    }
}

class ArticlesItemListEntity {
    
    var articles: [ArticlesItemEntity] = []
    
    required init(json: JSON, count: Int) {
        for i in 0..<count {
            self.articles.append(ArticlesItemEntity(json: json, index: i))
        }
    }
}

// MARK: - ArticleSingleItemEntity
class ArticleSingleItemEntity {
    
    var title: String = ""
    var id: String = ""
    var updatedAt: String = ""
    var likesCount: Int = 0
    var body: String = ""
    var tags: [String] = []
    var userName: String = ""
    var userIconUrl: String = ""
    
    required init(json: JSON) {
        title = json["title"].stringValue
        id = json["id"].stringValue
        updatedAt = json["updated_at"].stringValue
        likesCount = json["likes_count"].intValue
        body = json["body"].stringValue
        let tagArray = json["tags"].arrayValue
        for tag in tagArray {
            self.tags.append(tag["name"].stringValue)
        }
        userName = json["user"]["id"].stringValue
        userIconUrl = json["user"]["profile_image_url"].stringValue
    }
}

