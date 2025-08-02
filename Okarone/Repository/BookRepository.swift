import Foundation

class BookRepository {
    private let versionURL = "https://raw.githubusercontent.com/sourav-ganguly/okarone-json/refs/heads/main/db-version.json"
    private let bookDBURL = "https://raw.githubusercontent.com/sourav-ganguly/okarone-json/refs/heads/main/book-db.json"
    
    private let userDefaults = UserDefaults.standard
    private let lastVersionKey = "lastDownloadedDBVersion"
    private let bookDataKey = "bookData"
    
    func checkDatabaseVersion() async throws -> DatabaseVersion {
        print("📡 Checking database version from: \(versionURL)")
        
        guard let url = URL(string: versionURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        print("📊 Version API Response Status: \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        let versionData = String(data: data, encoding: .utf8) ?? "No data"
        print("📄 Version API Response Data: \(versionData)")
        
        do {
            let databaseVersion = try JSONDecoder().decode(DatabaseVersion.self, from: data)
            print("✅ Successfully decoded version: \(databaseVersion.version)")
            return databaseVersion
        } catch {
            print("❌ Failed to decode version data: \(error)")
            throw NetworkError.decodingError(error)
        }
    }
    
    func downloadBookDatabase() async throws -> [BookItem] {
        print("📡 Downloading book database from: \(bookDBURL)")
        
        guard let url = URL(string: bookDBURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        print("📊 Book DB API Response Status: \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        let bookDataString = String(data: data, encoding: .utf8) ?? "No data"
        print("📄 Book DB API Response Data (first 500 chars): \(String(bookDataString.prefix(500)))...")
        
        do {
            let bookItems = try JSONDecoder().decode([BookItem].self, from: data)
            print("✅ Successfully decoded \(bookItems.count) book items")
            return bookItems
        } catch {
            print("❌ Failed to decode book data: \(error)")
            throw NetworkError.decodingError(error)
        }
    }
    
    func getLastDownloadedVersion() -> String? {
        return userDefaults.string(forKey: lastVersionKey)
    }
    
    func saveLastDownloadedVersion(_ version: String) {
        userDefaults.set(version, forKey: lastVersionKey)
        print("💾 Saved last downloaded version: \(version)")
    }
    
    func saveBookData(_ books: [BookItem]) {
        do {
            let data = try JSONEncoder().encode(books)
            userDefaults.set(data, forKey: bookDataKey)
            print("💾 Saved \(books.count) book items to local storage")
        } catch {
            print("❌ Failed to save book data: \(error)")
        }
    }
    
    func getLocalBookData() -> [BookItem] {
        guard let data = userDefaults.data(forKey: bookDataKey) else {
            print("📚 No local book data found")
            return []
        }
        
        do {
            let books = try JSONDecoder().decode([BookItem].self, from: data)
            print("📚 Loaded \(books.count) book items from local storage")
            return books
        } catch {
            print("❌ Failed to load local book data: \(error)")
            return []
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
} 