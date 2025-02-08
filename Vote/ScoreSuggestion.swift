//
//  ScoreSuggestion.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import Foundation

struct ScoreSuggestion : Codable {
    var headline: String
    
    var sourceUrl: String
    
    var number: Int
    
    var subjectId: Int
    
    var topic: String
    
    var userName: String
    
    var emailAddress: String
    
    init() {
        self.headline = ""
        self.sourceUrl = ""
        self.topic = ""
        self.number = 0
        self.subjectId = 0
        self.userName = ""
        self.emailAddress = ""
    }
}
