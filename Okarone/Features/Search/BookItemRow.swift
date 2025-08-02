import SwiftUI

// MARK: - Supporting Models and Views

struct BookItem: Identifiable {
    let id: String
    let title: String
    let author: String
    let coverURL: String?
}

struct BookItemRow: View {
    let book: BookItem
    
    var body: some View {
        NavigationLink(destination: BookDetailView(book: convertToSearchResultItem())) {
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
                    Text(book.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(book.author)
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
            bookEN: book.title,
            bookBN: book.title, // Using English title as placeholder for Bengali
            authorEN: book.author,
            authorBN: book.author, // Using English author as placeholder for Bengali
            publisherEN: "Sample Publisher",
            publisherBN: "স্যাম্পল প্রকাশক",
            stallEN: "Stall A-1",
            stallBN: "স্টল এ-১",
            directionEN: "Near the main entrance",
            directionBN: "মূল প্রবেশপথের কাছে",
            blockEN: "Block A",
            blockBN: "ব্লক এ"
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

