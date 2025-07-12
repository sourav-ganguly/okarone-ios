//
//  ContentView.swift
//  Okarone
//
//  Created by Sourav on 15/5/25.
//
import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            TabView {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "list.bullet")
                    }
            }
            .accentColor(.blue)
        }
    }
}

// #Preview is a swift macro
#Preview {
    RootView()
}
