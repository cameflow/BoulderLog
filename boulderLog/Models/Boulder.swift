//
//  Boulder.swift
//  boulderLog
//
//  Created by Alejandro Terrazas on 17/01/22.
//

import Foundation

struct Boulder: Comparable, Codable {
    
    var name:           String
    var description:    String
    var grade:          String?
    var location:       String?
    var attempts:       String?
    var imageName:      String?
    var rating:         Int?
    
    
    init(name: String, description: String) {
        self.name           = name
        self.description    = description
    }
    
    static func <(lhs: Boulder, rhs: Boulder) -> Bool {
            return lhs.name < rhs.name
    }
    
}
