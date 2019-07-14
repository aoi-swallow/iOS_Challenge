//
//  Realm+.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/14.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RealmSwift

extension Realm {
    
    public var queue: OperationQueue {
        get {
            if let queue = objc_getAssociatedObject(self, &StoredPropaties.queue) as? OperationQueue {
                return queue
            }
            
            let queue = self.createDefaultQueue()
            self.queue = queue
            return queue
        }
        
        set {
            objc_setAssociatedObject(self, &StoredPropaties.queue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func writeBackground(block: @escaping (_ store: Realm) -> Void, completion: @escaping () -> Void) {
        
        self.queue.addOperation {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: self.configuration)
                    try realm.write {
                        block(realm)
                    }
                } catch {
                    // Error Handling
                }
                OperationQueue.main.addOperation {
                    completion()
                }
            }
        }
    }
    
    private enum StoredPropaties {
        static var queue: Void?
    }
    
    private func createDefaultQueue() -> OperationQueue {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = QualityOfService.default
        return queue
    }
}
