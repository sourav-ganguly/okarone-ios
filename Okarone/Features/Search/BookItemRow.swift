import SwiftUI

// MARK: - Supporting Models and Views

//struct BookItem: Identifiable {
//    let id: String
//    let title: String
//    let author: String
//    let coverURL: String?
//}

struct BookItemRow: View {
    let book: BookItem
    
    var body: some View {
        NavigationLink(destination: SearchDetailView(book: convertToSearchResultItem())) {
            HStack(spacing: 12) {
                // Book Cover Placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 70)
                    .overlay(
                        Image(systemName: "book.closed")
                            .foregroundColor(.gray)
                    )
                
                // Book Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.bookBN)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(book.authorBN)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func convertToSearchResultItem() -> SearchResultItem {
        return SearchResultItem(
            id: book.id,
            bookEN: book.bookEN,
            bookBN: book.bookBN, // Using English title as placeholder for Bengali
            authorEN: book.authorEN,
            authorBN: book.authorBN, // Using English author as placeholder for Bengali
            publisherEN: book.publisherEN,
            publisherBN: book.publisherBN,
            stallEN: book.stallEN,
            stallBN: book.stallBN,
            directionEN: book.directionEN,
            directionBN: book.directionBN,
            blockEN: book.blockEN,
            blockBN: book.blockBN
        )
    }
}

// MARK: - Backdrop Modifier for Blur Effect

extension View {
    func backdrop(blur radius: CGFloat) -> some View {
        self.background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .cornerRadius(12)
                .blur(radius: radius / 2)
        )
    }
}

