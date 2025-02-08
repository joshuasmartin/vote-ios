//
//  SuggestSubjectView.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/3/25.
//

import SwiftUI

struct SuggestSubjectView: View {
    @State private var subjectType = 0
    
    @State private var name: String = ""
    
    @State private var userName: String = ""
    
    @State private var emailAddress: String = ""
    
    @State private var showNameAlert = false
    
    @State private var showUserNameAlert = false
    
    @State private var showEmailAddressAlert = false
    
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What should we add?")) {
                    Picker(selection: $subjectType, label: Text("Type")) {
                        Text("Retailer").tag(0)
                        Text("Brand").tag(1)
                    }
                }
                
                Section {
                    TextField("Name of the Retailer or Brand", text: $name)
                }
                
                Section {
                    TextField("Your Name", text: $userName)
                    
                    TextField("Your Email Address", text: $emailAddress)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                        .keyboardType(.emailAddress)
                }
                
                Section {
                    Button(action: {
                        Task { await suggestSubject() }
                    }) {
                        Text("Save and Continue")
                    }
                    
                    // Validate the name of the subject.
                    .alert("Oops!", isPresented: $showNameAlert) {
                        Button("OK", role: .cancel) {
                            // Do nothing when closed.
                        }
                    } message: {
                        Text("Name must contain at least 4 characters.")
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
            .navigationTitle("Suggestion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func suggestSubject() async {
        if (name.count < 4) {
            showNameAlert = true
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
        
        var suggestion = SubjectSuggestion()
        suggestion.name = name
        suggestion.type = typeForInt(int: subjectType)
        suggestion.userName = userName
        suggestion.emailAddress = emailAddress
        
        guard let encoded = try? JSONEncoder().encode(suggestion) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://api.withyourwallet.app/api/Subjects/Suggest")!
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
    
    private func typeForInt(int: Int) -> String {
        if (int == 0) {
            return "Retailer"
        } else if (int == 1) {
            return "Brand"
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
        return absoluteString == text
    }
}

#Preview {
    SuggestSubjectView()
}
