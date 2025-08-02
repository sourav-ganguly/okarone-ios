import XCTest
@testable import Okarone

final class DownloadDatabaseUseCaseTests: XCTestCase {
    var useCase: DownloadDatabaseUseCase!
    var mockRepository: MockBookRepository!
    
    override func setUpWithError() throws {
        mockRepository = MockBookRepository()
        useCase = DownloadDatabaseUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        useCase = nil
        mockRepository = nil
    }
    
    func testExecute_WhenVersionChanged_ShouldDownloadNewData() async throws {
        // Given
        let serverVersion = DatabaseVersion(version: "20250803")
        let localVersion = "20250802"
        let newBooks = [
            BookItem(id: "1", bookEN: "Test Book", bookBN: "টেস্ট বই", authorEN: "Test Author", authorBN: "টেস্ট লেখক", publisherEN: "Test Publisher", publisherBN: "টেস্ট প্রকাশক", stallEN: "123", stallBN: "১২৩", directionEN: "Test Direction", directionBN: "টেস্ট দিকনির্দেশনা", blockEN: "A", blockBN: "এ", duplicate: false)
        ]
        
        mockRepository.mockVersion = serverVersion
        mockRepository.mockBooks = newBooks
        mockRepository.lastDownloadedVersion = localVersion
        
        // When
        let result = await useCase.execute()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, "1")
        XCTAssertEqual(mockRepository.savedVersion, serverVersion.version)
        XCTAssertEqual(mockRepository.savedBooks?.count, 1)
    }
    
    func testExecute_WhenVersionSame_ShouldReturnLocalData() async throws {
        // Given
        let serverVersion = DatabaseVersion(version: "20250803")
        let localVersion = "20250803"
        let localBooks = [
            BookItem(id: "1", bookEN: "Local Book", bookBN: "লোকাল বই", authorEN: "Local Author", authorBN: "লোকাল লেখক", publisherEN: "Local Publisher", publisherBN: "লোকাল প্রকাশক", stallEN: "123", stallBN: "১২৩", directionEN: "Local Direction", directionBN: "লোকাল দিকনির্দেশনা", blockEN: "A", blockBN: "এ", duplicate: false)
        ]
        
        mockRepository.mockVersion = serverVersion
        mockRepository.lastDownloadedVersion = localVersion
        mockRepository.localBooks = localBooks
        
        // When
        let result = await useCase.execute()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, "1")
        XCTAssertEqual(result.first?.bookEN, "Local Book")
        XCTAssertNil(mockRepository.savedVersion) // Should not save new version
        XCTAssertNil(mockRepository.savedBooks) // Should not save new books
    }
    
    func testExecute_WhenFirstTimeDownload_ShouldDownloadData() async throws {
        // Given
        let serverVersion = DatabaseVersion(version: "20250803")
        let newBooks = [
            BookItem(id: "1", bookEN: "First Book", bookBN: "প্রথম বই", authorEN: "First Author", authorBN: "প্রথম লেখক", publisherEN: "First Publisher", publisherBN: "প্রথম প্রকাশক", stallEN: "123", stallBN: "১২৩", directionEN: "First Direction", directionBN: "প্রথম দিকনির্দেশনা", blockEN: "A", blockBN: "এ", duplicate: false)
        ]
        
        mockRepository.mockVersion = serverVersion
        mockRepository.mockBooks = newBooks
        mockRepository.lastDownloadedVersion = nil // First time
        
        // When
        let result = await useCase.execute()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, "1")
        XCTAssertEqual(mockRepository.savedVersion, serverVersion.version)
        XCTAssertEqual(mockRepository.savedBooks?.count, 1)
    }
}

// MARK: - Mock Repository
class MockBookRepository: BookRepository {
    var mockVersion: DatabaseVersion?
    var mockBooks: [BookItem]?
    var lastDownloadedVersion: String?
    var localBooks: [BookItem] = []
    
    var savedVersion: String?
    var savedBooks: [BookItem]?
    
    override func checkDatabaseVersion() async throws -> DatabaseVersion {
        guard let mockVersion = mockVersion else {
            throw NetworkError.invalidResponse
        }
        return mockVersion
    }
    
    override func downloadBookDatabase() async throws -> [BookItem] {
        guard let mockBooks = mockBooks else {
            throw NetworkError.invalidResponse
        }
        return mockBooks
    }
    
    override func getLastDownloadedVersion() -> String? {
        return lastDownloadedVersion
    }
    
    override func saveLastDownloadedVersion(_ version: String) {
        savedVersion = version
    }
    
    override func saveBookData(_ books: [BookItem]) {
        savedBooks = books
    }
    
    override func getLocalBookData() -> [BookItem] {
        return localBooks
    }
} 