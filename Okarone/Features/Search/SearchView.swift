import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [BookItem] = []
    @State private var allBooks: [BookItem] = []
    private let bookRepository = BookRepository()

    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                    // Search Bar in top area
                    SearchBar(searchText: $searchText, searchResults: $searchResults, allBooks: allBooks)
                        .padding(.top, 8)

                    // Search Results
                    SearchResultContainerView(searchResults: $searchResults)
                }
                .background(
                        Image("appBg")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea(.all, edges: .all)
                )
                .onAppear {
                    loadBookList()
                }
        }
    }

    private func loadBookList() {
        allBooks = bookRepository.getLocalBookData()
        print("📚 Loaded \(allBooks.count) books for search")
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searchResults: [BookItem]
    let allBooks: [BookItem]

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 12)

            TextField("Search books...", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 12)
                .onChange(of: searchText) { newValue in
                    performSearch(query: newValue)
                }

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    searchResults = []
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.7))
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .backdrop(blur: 0)
        )
        .padding(.horizontal, 16)
    }

    private func performSearch(query: String) {
        if query.isEmpty {
            searchResults = []
        } else {
            // Search in both Bengali and English fields
            searchResults = allBooks.filter { book in
                book.bookBN.localizedCaseInsensitiveContains(query) ||
                book.bookEN.localizedCaseInsensitiveContains(query) ||
                book.authorBN.localizedCaseInsensitiveContains(query) ||
                book.authorEN.localizedCaseInsensitiveContains(query) ||
                book.publisherBN.localizedCaseInsensitiveContains(query) ||
                book.publisherEN.localizedCaseInsensitiveContains(query)
            }
            print("🔍 Found \(searchResults.count) results for query: '\(query)'")
        }
    }
}

struct SearchResultContainerView: View {
    @Binding var searchResults: [BookItem]

    var body: some View {
        VStack(spacing: 0) {
            if !searchResults.isEmpty {
                if #available(iOS 26.0, *) {
                    List(searchResults) { book in
                        BookItemRow(book: book)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                } else {
                    List(searchResults) { book in
                        BookItemRow(book: book)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                     .background(
                         RoundedRectangle(cornerRadius: 12)
                             .fill(Color.white.opacity(0.0))
                             .backdrop(blur: 0.4)
                     )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
            }

            Spacer()
        }
    }
}

#Preview {
    RootView()
}
