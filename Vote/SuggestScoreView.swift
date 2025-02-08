//
//  SuggestScoreView.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import SwiftUI

struct SuggestScoreView: View {
    var subject: Subject
    
    @State private var topic = 0
    
    @State private var number = 3
    
    @State private var headline: String = ""
    
    @State private var sourceUrl: String = ""
    
    @State private var userName: String = ""
    
    @State private var emailAddress: String = ""
    
    @State private var showHeadlineAlert = false
    
    @State private var showSourceUrlAlert = false
    
    @State private var showUserNameAlert = false
    
    @State private var showEmailAddressAlert = false
    
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $topic, label: Text("Topic")) {
                        Text("DEI").tag(0)
                        Text("Environment").tag(1)
                        Text("Unions").tag(2)
                        Text("Politics").tag(3)
                    }
                    
                    Picker(selection: $number, label: Text("Score")) {
                        Text("Positive").tag(3)
                        Text("Negative").tag(1)
                    }
                }
                
                Section(header: Text("Article Headline or Summary")) {
                    TextField("Headline", text: $headline)
                }
                
                Section(header: Text("Link to Prove Your Score")) {
                    TextField("Source URL", text: $sourceUrl)
                }
                
                Section {
                    TextField("Your Name", text: $userName)
                    
                    TextField("Your Email Address", text: $emailAddress)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                        .keyboardType(.emailAddress)
                }
                
                Section {
                    Button(action: {
                        Task { await suggestScore() }
                    }) {
                        Text("Save and Continue")
                    }
                    
                    // Validate the headline.
                    .alert("Oops!", isPresented: $showHeadlineAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("Headline must contain at least 7 characters.")
                    }
                    
                    // Validate the source URL.
                    .alert("Oops!", isPresented: $showSourceUrlAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("Must provide a valid source URL to prove your score.")
                    }
                    
                    // Validate the user name.
                    .alert("Oops!", isPresented: $showUserNameAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("Your name must contain at least 4 characters.")
                    }
                    
                    // Validate the Email address.
                    .alert("Oops!", isPresented: $showEmailAddressAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("You must provide a valid Email address.")
                    }
                    
                    // Show a success alert.
                    .alert("Yayy!", isPresented: $showSuccessAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("Thank you for your suggestion. We'll review and add it to the database.")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        let resign = #selector(UIResponder.resignFirstResponder)
                        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                    }
                }
            }
            .navigationTitle("Suggest a Score")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func suggestScore() async {
        
        if (headline.count < 7) {
            showHeadlineAlert = true
            return
        }
        
        if (sourceUrl.count < 4) {
            showSourceUrlAlert = true
            return
        }
        
        if (userName.count < 4) {
            showUserNameAlert = true
            return
        }
        
        if (!validateEmailAddress(emailAddress)) {
            showEmailAddressAlert = true
            return
        }
        
        var suggestion = ScoreSuggestion()
        suggestion.headline = headline
        suggestion.sourceUrl = sourceUrl
        suggestion.subjectId = subject.id
        suggestion.number = number
        suggestion.topic = topicForInt(int: topic)
        suggestion.userName = userName
        suggestion.emailAddress = emailAddress
        
        guard let encoded = try? JSONEncoder().encode(suggestion) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://api.withyourwallet.app/api/Subjects/\(subject.id)/Scores")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (_, _) = try await URLSession.shared.upload(for: request, from: encoded)
            showSuccessAlert = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
    
    private func topicForInt(int: Int) -> String {
        if (int == 0) {
            return "DEI"
        } else if (int == 1) {
            return "Environment"
        } else if (int == 2) {
            return "Unions"
        } else if (int == 3) {
            return "Politics"
        } else {
            return ""
        }
    }
    
    private func validateEmailAddress(_ rawValue: String) -> Bool {
        let detector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        )
        
        let range = NSRange(
            rawValue.startIndex..<rawValue.endIndex,
            in: rawValue
        )
        
        let matches = detector?.matches(
            in: rawValue,
            options: [],
            range: range
        )
        
        // We only want our string to contain a single email
        // address, so if multiple matches were found, then
        // we fail our validation process and return nil:
        guard let match = matches?.first, matches?.count == 1 else {
            return false
        }
        
        // Verify that the found link points to an email address,
        // and that its range covers the whole input string:
        guard match.url?.scheme == "mailto", match.range == range else {
            return false
        }
        
        return true
    }
    
    private func validateUrl(_ text: String) -> Bool {
        let types = NSTextCheckingResult.CheckingType.link.rawValue
        
        guard
            let dataDetector = try? NSDataDetector(types: types),
            let match = dataDetector
                .matches(in: text, options: [], range: NSRangeFromString(text))
                .first,
            let absoluteString = match.url?.absoluteString
        else { return false }
        
        return true
    }
}

#Preview {
    let subject = Subject(name: "Walmart", id: 1)
    SuggestScoreView(subject: subject)
}
