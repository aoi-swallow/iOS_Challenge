//
//  StockItemEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

// MARK: StockItemEntity
final class StockItemEntity: Object, Decodable {
    
    @objc dynamic var renderedBody: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var coediting: Bool = false
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var createdAt: String = ""
    @objc dynamic var group: GroupEntity?
    @objc dynamic var id: String = ""
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var isPrivate: Bool = false
    @objc dynamic var reactionsCount: Int = 0
    var tags = List<TagEntity>()
    @objc dynamic var title: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var user: UserEntity?
    var pageViewsCount = RealmOptional<Int>()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case renderedBody = "rendered_body"
        case body
        case coediting
        case commentsCount = "comments_count"
        case createdAt = "created_at"
        case group
        case id
        case likesCount = "likes_count"
        case isPrivate = "private"
        case reactionsCount = "reactions_count"
        case tags
        case title
        case updatedAt = "updated_at"
        case url
        case user
        case pageViewsCount = "page_views_count"
    }
    
    enum QueryType: String {
        case renderedBody
        case body
        case coediting
        case commentsCount
        case createdAt
        case group
        case id
        case likesCount
        case isPrivate
        case reactionsCount
        case tags
        case title
        case updatedAt
        case url
        case user
        case pageViewsCount
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        renderedBody = try container.decode(String.self, forKey: .renderedBody)
        body = try container.decode(String.self, forKey: .body)
        coediting = try container.decode(Bool.self, forKey: .coediting)
        commentsCount = try container.decode(Int.self, forKey: .commentsCount)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        group = try container.decodeIfPresent(GroupEntity.self, forKey: .group)
        id = try container.decode(String.self, forKey: .id)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
        reactionsCount = try container.decode(Int.self, forKey: .reactionsCount)
        let tagArray = try container.decode([TagEntity].self, forKey: .tags)
        tags = tagArray.reduce(List<TagEntity>()) { $0.append($1); return $0 }
        title = try container.decode(String.self, forKey: .title)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        url = try container.decode(String.self, forKey: .url)
        user = try container.decodeIfPresent(UserEntity.self, forKey: .user)
        pageViewsCount.value = try container.decodeIfPresent(Int.self, forKey: .pageViewsCount)
    }
}

// MARK: TagEntity
final class TagEntity: Object, Decodable {
    
    @objc dynamic var name: String = ""
    var versions = List<String>()
    
    override static func primaryKey() -> String {
        return "name"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case versions
    }
    
    enum QueryType: String {
        case name
        case versions
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let versionArray = try container.decode([String].self, forKey: .versions)
        versions = versionArray.reduce(List<String>()) { $0.append($1); return $0 }
    }
}

// MARK: - GroupEntity
final class GroupEntity: Object, Decodable {
    
    @objc dynamic var createdAt: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isPrivate: Bool = false
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var urlName: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case name
        case isPrivate = "private"
        case updatedAt = "updated_at"
        case urlName = "url_name"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        urlName = try container.decode(String.self, forKey: .urlName)
    }
}

