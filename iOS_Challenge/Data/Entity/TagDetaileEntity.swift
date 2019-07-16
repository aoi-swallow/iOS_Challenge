//
//  TagDetaileEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

// MARK: TagDetaileEntity
class TagDetailEntity: Object, Decodable {
    
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var iconUrl: String?
    @objc dynamic var id: String = ""
    @objc dynamic var itemsCount: Int = 0
    
    override static func primaryKey() -> String {
        
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case followersCount = "followers_count"
        case iconUrl = "icon_url"
        case id
        case itemsCount = "items_count"
    }
    
    enum QueryType: String {
        case followersCount
        case iconUrl
        case id
        case itemsCount
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        followersCount = try container.decode(Int.self, forKey: .followersCount)
        iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
        id = try container.decode(String.self, forKey: .id)
        itemsCount = try container.decode(Int.self, forKey: .itemsCount)
    }
}
