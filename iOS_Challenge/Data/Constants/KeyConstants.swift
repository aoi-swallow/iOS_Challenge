//
//  KeyConstants.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/11.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

struct AppKey {
    
    enum Keychain: String {
        case token
    }
}

struct AppSetting {
    
    static let realmSchemaVersion = 1
    static let realmOldSchemaVersion = 0
    static let realmThresholdMB = 500
    static let realmThresholdRatio = 0.5
}

// MARK: LoadStatus
enum LoadStatus {
    case initial
    case fetching
    case full
}
