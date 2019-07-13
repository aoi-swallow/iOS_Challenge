//
//  RealmInstance.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

struct RealmModel {
    static var getRealm: Realm {
        return try! Realm(configuration: Realm.Configuration(schemaVersion: UInt64(AppSetting.realmSchemaVersion)))
    }
    
    static var config: Realm.Configuration {
        return Realm.Configuration(
            schemaVersion: UInt64(AppSetting.realmSchemaVersion),
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < AppSetting.realmOldSchemaVersion  {}
        },
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                // totalBytesはディスク上のRealmファイルの容量を示します。 (使用領域 + 空き領域)
                // usedBytesは実際に使用している領域の容量を示します。
                // ファイルサイズが500MB以上、かつ使用領域が全体の50%より少ない場合にコンパクションを実行
                let oneHundredMB = AppSetting.realmThresholdMB * 1024 * 1024
                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < AppSetting.realmThresholdRatio
        })
    }
    
    static func createRealm() -> Realm? {
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            assertionFailure("realm error: \(error)")
            var schema = config
            schema.deleteRealmIfMigrationNeeded = true
            return try? Realm(configuration: schema)
        }
    }
    
}
