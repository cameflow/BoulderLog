//
//  Location.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 29/01/22.
//

import Foundation

struct Location: Comparable, Codable, Hashable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func <(lhs: Location, rhs: Location) -> Bool {
            return lhs.name < rhs.name
        }
    
}
