//
//  User.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import Foundation

struct User : Identifiable, Codable {
    var id: Int
    
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = 0
    }
}
