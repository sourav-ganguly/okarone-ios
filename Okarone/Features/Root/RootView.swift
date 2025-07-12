//
//  ContentView.swift
//  Okarone
//
//  Created by Sourav on 15/5/25.
//
import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                ForEach(viewModel.tabs, id: \.self) { tab in
                    tabView(for: tab)
                        .tabItem {
                            Label(tab.label, systemImage: tab.systemImage)
                        }
                }
            }
            .accentColor(.blue)
        }
    }
    
    @ViewBuilder
    private func tabView(for tab: AppTab) -> some View {
        switch tab {
        case .bookstoreSearch:
            SearchView()
        case .okaroneFeed:
            FeedView()
        default:
            Text(tab.label)
        }
    }
}

#Preview {
    RootView()
}
