import Foundation

struct BookItem: Codable, Identifiable {
    let id: String
    let bookEN: String
    let bookBN: String
    let authorEN: String
    let authorBN: String
    let publisherEN: String
    let publisherBN: String
    let stallEN: String
    let stallBN: String
    let directionEN: String
    let directionBN: String
    let blockEN: String
    let blockBN: String
    let duplicate: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case bookEN = "Book_EN"
        case bookBN = "Book_BN"
        case authorEN = "Author_EN"
        case authorBN = "Author_BN"
        case publisherEN = "Publisher_EN"
        case publisherBN = "Publisher_BN"
        case stallEN = "Stall_EN"
        case stallBN = "Stall_BN"
        case directionEN = "Direction_EN"
        case directionBN = "Direction_BN"
        case blockEN = "Block_EN"
        case blockBN = "Block_BN"
        case duplicate = "Duplicate"
    }
} 