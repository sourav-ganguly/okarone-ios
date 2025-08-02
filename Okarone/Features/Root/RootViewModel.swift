//
//  RootViewModel.swift
//  Okarone
//
//  Created by Sourav on 13/7/25.
//
import SwiftUI

class RootViewModel: ObservableObject {
    @Published var tabs: [AppTab] = []
    @Published var bookItems: [BookItem] = []
    @Published var isLoadingDatabase = false
    
    private let getAppTabsUseCase: GetAppTabsUseCase
    private let downloadDatabaseUseCase: DownloadDatabaseUseCase
    
    init(getAppTabsUseCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl(),
         downloadDatabaseUseCase: DownloadDatabaseUseCase = DownloadDatabaseUseCaseImpl()) {
        self.getAppTabsUseCase = getAppTabsUseCase
        self.downloadDatabaseUseCase = downloadDatabaseUseCase
        self.tabs = getAppTabsUseCase.execute()
        
        // Start database download when app loads
        Task {
            await downloadDatabase()
        }
    }
    
    @MainActor
    private func downloadDatabase() async {
        isLoadingDatabase = true
        print("🔄 Starting database download in RootViewModel...")
        
        let books = await downloadDatabaseUseCase.execute()
        self.bookItems = books
        
        isLoadingDatabase = false
        print("✅ Database download completed in RootViewModel. Loaded \(books.count) books.")
    }
}
