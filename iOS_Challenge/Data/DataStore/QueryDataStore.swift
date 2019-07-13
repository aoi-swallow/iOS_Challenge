//
//  QueryDataStore.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

// MARK: - QueryDataStore
protocol QueryDataStore {
    
    func readAll<T: Object>(_ type: T.Type) -> [T]
    func readContains<T: Object>(_ type: T.Type, key: String, query: String) -> [T]
    func readIn<T: Object>(_ type: T.Type, key: String, query: [AnyObject]) -> [T]
    @available(iOS, deprecated: 8.0)
    func readEqual<T: Object>(_ type: T.Type, key: String, query: AnyObject) -> [T]
    @available(iOS, deprecated: 8.0)
    func readCustom<T: Object>(_ type: T.Type, predicates: NSPredicate) -> [T]
    func createObject<T: Object>(data: [T]) -> Bool
    func deleteObject<T: Object>(data: [T]) -> Bool
    func delete<T: Object>(_ type: T.Type, predicates: NSPredicate) -> Bool
    func deleteAll<T: Object>(_ type: T.Type) -> Bool
    
    func readEqual<T, V>(key: String, query: V) -> [T] where T: Object, V: Hashable
    func readCustom<T>(predicates: NSPredicate) -> [T] where T: Object
}

// MARK: - QueryDataStoreImpl
final class QueryDataStoreImpl: QueryDataStore {
    
    private let realm = RealmModel.getRealm
    
    
    // MARK: - QueryDataStore
    
    func readAll<T>(_ type: T.Type = T.self) -> [T] where T: Object {
        let result = realm.objects(T.self)
        return Array(result)
    }
    
    func readContains<T>(_ type: T.Type = T.self, key: String, query: String) -> [T] where T: Object {
        let result = realm.objects(T.self).filter(NSPredicate(key, contains: query))
        return Array(result)
    }
    
    func readIn<T>(_ type: T.Type = T.self, key: String, query: [AnyObject]) -> [T] where T: Object {
        let result = realm.objects(T.self).filter(NSPredicate(key, valuesIn: query))
        return Array(result)
    }
    
    
    func readEqual<T>(_ type: T.Type = T.self, key: String, query: AnyObject) -> [T] where T: Object {
        let result = realm.objects(T.self).filter(NSPredicate(key, equal: query))
        return Array(result)
    }
    
    func readCustom<T>(_ type: T.Type = T.self, predicates: NSPredicate) -> [T] where T: Object {
        let result = realm.objects(T.self).filter(predicates)
        return Array(result)
    }
    
    func createObject<T>(data: [T]) -> Bool where T: Object {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            return false
        }
        return true
    }
    
    func deleteObject<T>(data: [T]) -> Bool where T: Object {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            return false
        }
        return true
    }
    
    func delete<T>(_ type: T.Type = T.self, predicates: NSPredicate) -> Bool where T: Object {
        do {
            let obj = realm.objects(T.self).filter(predicates)
            try realm.write {
                realm.delete(obj)
            }
        } catch {
            return false
        }
        return true
    }
    
    func deleteAll<T>(_ type: T.Type = T.self) -> Bool where T: Object {
        do {
            let obj = realm.objects(T.self)
            try realm.write {
                realm.delete(obj)
            }
        } catch {
            return false
        }
        return true
    }
    
    
    func readEqual<T, V>(key: String, query: V) -> [T] where T: Object, V: Hashable {
        let result = realm.objects(T.self).filter(NSPredicate(key, equal: query as AnyObject))
        return Array(result)
    }
    func readCustom<T>(predicates: NSPredicate) -> [T] where T: Object {
        let result = realm.objects(T.self).filter(predicates)
        return Array(result)
    }
}

