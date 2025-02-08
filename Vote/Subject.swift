//
//  Subject.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/3/25.
//

import Foundation

struct Subject : Identifiable, Codable {
    var id: Int
    
    var name: String
    
    var diversityScore: Int
    
    var environmentalScore: Int
    
    var unionScore: Int
    
    var lobbyingScore: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.diversityScore = 0
        self.environmentalScore = 0
        self.unionScore = 0
        self.lobbyingScore = 0
    }
}
