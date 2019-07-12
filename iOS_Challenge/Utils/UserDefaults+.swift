//
//  UserDefaults+.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension UserDefaults {
    
    class Keys {
        
        fileprivate init() {}
    }
    
    class Key<Type>: Keys {
        
        let name: String
        let defaultValue: Type
        let subject: BehaviorSubject<Type>
        
        public init(_ name: String, defaultValue: Type) {
            
            self.name = name
            self.defaultValue = defaultValue
            self.subject = BehaviorSubject<Type>(value: defaultValue)
        }
        
        public func value() -> Type {
            
            return UserDefaults.standard[self]
        }
        
        public func set(_ value: Type) {
            
            if let value = value as? UDOptional, value.isNil {
                UserDefaults.standard.removeObject(forKey: name)
            } else {
                UserDefaults.standard.set(value, forKey: name)
            }
            self.subject.onNext(value)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: self.notificationName(), object: nil)
        }
        
        public func notificationName() -> Notification.Name {
            
            return Notification.Name("userdefaults.notif.\(name)")
        }
        
        public func asObservable() -> Observable<Type> {
            
            return self.subject.asObservable()
        }
    }
}

public protocol UDOptional {
    
    var isNil: Bool { get }
}

public protocol UDDefaultValuedOptional: UDOptional {
    
    static var defaultValue: Self { get }
}

extension Optional: UDDefaultValuedOptional {
    
    public static var defaultValue: Wrapped? { return nil }
    public var isNil: Bool { return self == nil }
}

extension UserDefaults.Key where Type: UDDefaultValuedOptional {
    
    public convenience init(_ name: String) {
        self.init(name, defaultValue: Type.defaultValue)
    }
}

extension UserDefaults.Key where Type: UDOptional {
    
    public func clear() {
        
        UserDefaults.standard.removeObject(forKey: name)
        UserDefaults.standard.synchronize()
    }
}


public extension UserDefaults {
    
    func object<Type>(forKey key: Key<Type>) -> Type {
        
        return (object(forKey: key.name) as? Type) ?? key.defaultValue
    }
    
    subscript<Type>(key: Key<Type>) -> Type {
        
        return object(forKey: key)
    }
}

extension UserDefaults.Keys {
    
    public struct Auth {
        public static let code = UserDefaults.Key<String>("auth.code", defaultValue: "")
        public static let url = UserDefaults.Key<String>("auth.url", defaultValue: "")
    }
}
