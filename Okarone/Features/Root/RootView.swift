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
            
            // Loading overlay while database is being downloaded
            if viewModel.isLoadingDatabase {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
                    Text("Downloading database...")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top, 16)
                }
            }
        }
    }
    
    @ViewBuilder
    private func tabView(for tab: AppTab) -> some View {
        switch tab {
        case .bookstoreSearch:
            SearchView()
        case .okaroneFeed:
            FeedView()
        case .readForToday:
            TodayRead()
        default:
            Text(tab.label)
        }
    }
}

#Preview {
    RootView()
}
