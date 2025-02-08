//
//  FetchScores.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import Foundation

class FetchScores: ObservableObject {
    @Published var scores = [Score]()
    
    @Published var loading = false
    
    var subjectId: String
      
    init(subjectId: String) {
        self.subjectId = subjectId
        
        DispatchQueue.main.async {
            self.loading = true
        }
        
        let url = URL(string: "https://api.withyourwallet.app/api/Subjects/\(subjectId)/Scores")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let scores = data {
                    let interpretedData = try JSONDecoder().decode([Score].self, from: scores)
                    DispatchQueue.main.async {
                        self.scores = interpretedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
            
            DispatchQueue.main.async {
                self.loading = false
            }
        }.resume()
    }
}
