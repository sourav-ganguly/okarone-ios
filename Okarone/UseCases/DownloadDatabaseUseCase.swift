import Foundation

protocol DownloadDatabaseUseCase {
    func execute() async -> [BookItem]
}

class DownloadDatabaseUseCaseImpl: DownloadDatabaseUseCase {
    private let repository: BookRepository
    
    init(repository: BookRepository = BookRepository()) {
        self.repository = repository
    }
    
    func execute() async -> [BookItem] {
        print("🚀 Starting database download process...")
        
        do {
            // Check current database version from server
            let currentVersion = try await repository.checkDatabaseVersion()
            print("📋 Current server version: \(currentVersion.version)")
            
            // Get last downloaded version
            let lastVersion = repository.getLastDownloadedVersion()
            print("📋 Last downloaded version: \(lastVersion ?? "None")")
            
            // Check if we need to update
            if let lastVersion = lastVersion, lastVersion == currentVersion.version {
                print("✅ Database is up to date. Loading from local storage...")
                return repository.getLocalBookData()
            } else {
                print("🔄 Database version changed or first time download. Downloading new data...")
                
                // Download new book database
                let newBooks = try await repository.downloadBookDatabase()
                
                // Save new version and data
                repository.saveLastDownloadedVersion(currentVersion.version)
                repository.saveBookData(newBooks)
                
                print("✅ Database download completed successfully!")
                return newBooks
            }
            
        } catch {
            print("❌ Database download failed: \(error.localizedDescription)")
            
            // Return local data if available, otherwise empty array
            let localData = repository.getLocalBookData()
            if !localData.isEmpty {
                print("📚 Returning cached data due to download failure")
            } else {
                print("📚 No cached data available")
            }
            return localData
        }
    }
} 