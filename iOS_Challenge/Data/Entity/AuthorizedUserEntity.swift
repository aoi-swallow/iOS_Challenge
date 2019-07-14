//
//  AuthorizedUserEntity.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

// MARK: AuthorizedUserEntity
final class AuthorizedUserEntity: Object, Decodable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var descriptions: String?
    @objc dynamic var facebookID: String?
    @objc dynamic var followeesCount: Int = 0
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var githubLoginName: String?
    @objc dynamic var itemsCount: Int = 0
    @objc dynamic var linkedInID: String?
    @objc dynamic var location: String?
    @objc dynamic var name: String = ""
    @objc dynamic var organization: String?
    @objc dynamic var permanentID: Int = 0
    @objc dynamic var profileImageUrl: String = ""
    @objc dynamic var teamOnly: Bool = false
    @objc dynamic var twitterScreenName: String?
    @objc dynamic var websiteUrl: String?
    @objc dynamic var imageMonthlyUploadLimit: Int = 0
    @objc dynamic var imageMonthlyUploadRemaining: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case descriptions = "description"
        case facebookID = "facebook_id"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case githubLoginName = "github_login_name"
        case itemsCount = "items_count"
        case linkedInID = "linkedin_id"
        case location = "location"
        case name
        case organization
        case permanentID = "permanent_id"
        case profileImageUrl = "profile_image_url"
        case teamOnly = "team_only"
        case twitterScreenName = "twitter_screen_name"
        case websiteUrl = "website_url"
        case imageMonthlyUploadLimit = "image_monthly_upload_limit"
        case imageMonthlyUploadRemaining = "image_monthly_upload_remaining"
    }
    
    enum QueryType: String {
        case id
        case descriptions
        case facebookID
        case followeesCount
        case followersCount
        case githubLoginName
        case itemsCount
        case linkedInID
        case location
        case name
        case organization
        case permanentID
        case profileImageUrl
        case teamOnly
        case twitterScreenName
        case websiteUrl
        case imageMonthlyUploadLimit
        case imageMonthlyUploadRemaining
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        descriptions = try container.decodeIfPresent(String.self, forKey: .descriptions)
        facebookID = try container.decodeIfPresent(String.self, forKey: .facebookID)
        followeesCount = try container.decode(Int.self, forKey: .followeesCount)
        followersCount = try container.decode(Int.self, forKey: .followersCount)
        githubLoginName = try container.decodeIfPresent(String.self, forKey: .githubLoginName)
        itemsCount = try container.decode(Int.self, forKey: .itemsCount)
        linkedInID = try container.decodeIfPresent(String.self, forKey: .linkedInID)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        name = try container.decode(String.self, forKey: .name)
        organization = try container.decodeIfPresent(String.self, forKey: .organization)
        permanentID = try container.decode(Int.self, forKey: .permanentID)
        profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        teamOnly = try container.decode(Bool.self, forKey: .teamOnly)
        twitterScreenName = try container.decodeIfPresent(String.self, forKey: .twitterScreenName)
        websiteUrl = try container.decodeIfPresent(String.self, forKey: .websiteUrl)
        imageMonthlyUploadLimit = try container.decode(Int.self, forKey: .imageMonthlyUploadLimit)
        imageMonthlyUploadRemaining = try container.decode(Int.self, forKey: .imageMonthlyUploadRemaining)
    }
}
