//
//  Score.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import Foundation

struct Score : Identifiable, Codable {
    var id: Int
    
    var createdAt: String
    
    var headline: String
    
    var sourceUrl: String
    
    var number: Int
    
    var subjectId: Int
    
    var topic: String
    
    var createdByUser: User
    
    var createdByUserId: Int
    
    init(headline: String, sourceUrl: String, topic: String) {
        self.headline = headline
        self.id = 0
        self.sourceUrl = sourceUrl
        self.topic = topic
        self.number = 0
        self.subjectId = 0
        self.createdAt = Date.now.ISO8601Format()
        self.createdByUserId = 0
        self.createdByUser = User(name: "Unknown")
    }
}
