//
//  ContentView.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SubjectsView(filter: .retailers)
                .tabItem {
                    Label("Retailers", systemImage: "storefront")
                }
            SubjectsView(filter: .brands)
                .tabItem {
                    Label("Brands", systemImage: "shippingbox")
                }
            SuggestSubjectView()
                .tabItem {
                    Label("Suggest", systemImage: "plus.app")
                }
        }
        .preferredColorScheme(ColorScheme.light)
    }
}

#Preview {
    ContentView()
}
