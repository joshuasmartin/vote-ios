//
//  FetchSubject.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/3/25.
//

import Foundation

class FetchRetailers: ObservableObject {
    @Published var subjects = [Subject]()
    
    @Published var loading = false
      
    init() {
        DispatchQueue.main.async {
            self.loading = true
        }
        
        let url = URL(string: "https://api.withyourwallet.app/api/Subjects/Retailers")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let subjects = data {
                    let interpretedData = try JSONDecoder().decode([Subject].self, from: subjects)
                    DispatchQueue.main.async {
                        self.subjects = interpretedData
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
