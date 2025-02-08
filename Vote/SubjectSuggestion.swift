//
//  SubjectSuggestion.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import Foundation

struct SubjectSuggestion : Codable {
    var name: String
    
    var type: String
    
    var userName: String
    
    var emailAddress: String
    
    init() {
        self.name = ""
        self.type = ""
        self.userName = ""
        self.emailAddress = ""
    }
}
