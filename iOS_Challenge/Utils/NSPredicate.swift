//
//  NSPredicate.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/12.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation

public extension NSPredicate {
    
    private convenience init(expression property: String, _ operation: String, _ value: AnyObject) {
        self.init(format: "\(property) \(operation) %@", argumentArray: [value])
    }
    
    convenience init(_ property: String, equal value: AnyObject) {
        self.init(expression: property, "=", value)
    }
    
    convenience init(_ property: String, notEqual value: AnyObject) {
        self.init(expression: property, "!=", value)
    }
    
    convenience init(_ property: String, equalOrGreaterThan value: AnyObject) {
        self.init(expression: property, ">=", value)
    }
    
    convenience init(_ property: String, equalOrLessThan value: AnyObject) {
        self.init(expression: property, "<=", value)
    }
    
    convenience init(_ property: String, greaterThan value: AnyObject) {
        self.init(expression: property, ">", value)
    }
    
    convenience init(_ property: String, lessThan value: AnyObject) {
        self.init(expression: property, "<", value)
    }
    
    // If you use queries which contain backslack or single-quote with the following three methods, it may crash.(Use String extension realmEscaped)
    // partial match
    convenience init(_ property: String, contains q: String) {
        self.init(format: "\(property) CONTAINS '\(q)'")
    }
    
    // forward match
    convenience init(_ property: String, beginsWith q: String) {
        self.init(format: "\(property) BEGINSWITH '\(q)'")
    }
    
    // backward match
    convenience init(_ property: String, endsWith q: String) {
        self.init(format: "\(property) ENDSWITH '\(q)'")
    }
    
    
    convenience init(_ property: String, valuesIn values: [AnyObject]) {
        self.init(format: "\(property) IN %@", argumentArray: [values])
    }
    
    convenience init(_ property: String, between min: AnyObject, to max: AnyObject) {
        self.init(format: "\(property) BETWEEN {%@, %@}", argumentArray: [min, max])
    }
    
    convenience init(_ property: String, fromDate: Date?, toDate: Date?) {
        var format = "", args = [AnyObject]()
        if let from = fromDate {
            format += "\(property) >= %@"
            args.append(from as AnyObject)
        }
        if let to = toDate {
            if !format.isEmpty {
                format += " AND "
            }
            format += "\(property) <= %@"
            args.append(to as AnyObject)
        }
        if !args.isEmpty {
            self.init(format: format, argumentArray: args)
        } else {
            self.init(value: true)
        }
    }
    
    func compound(predicates: [NSPredicate], type: NSCompoundPredicate.LogicalType = .and) -> NSPredicate {
        var p = predicates; p.insert(self, at: 0)
        switch type {
        case .and: return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        case .or:  return NSCompoundPredicate(orPredicateWithSubpredicates:  p)
        case .not: return NSCompoundPredicate(notPredicateWithSubpredicate:  self.compound(predicates: p))
        }
    }
    
    func and(predicate: NSPredicate) -> NSPredicate {
        return self.compound(predicates: [predicate], type: .and)
    }
    
    func or(predicate: NSPredicate) -> NSPredicate {
        return self.compound(predicates: [predicate], type: .or)
    }
    
    func not(predicate: NSPredicate) -> NSPredicate {
        return self.compound(predicates: [predicate], type: .not)
    }
    
    static var empty: NSPredicate {
        return NSPredicate(value: true)
    }
}

