//
//  URL+.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/13.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation

public extension URL {
    func queryParams() -> [String : String] {
        var params = [String : String]()
        
        guard let comps = URLComponents(string: self.absoluteString) else {
            return params
        }
        guard let queryItems = comps.queryItems else { return params }
        
        for queryItem in queryItems {
            params[queryItem.name] = queryItem.value
        }
        return params
    }
}
