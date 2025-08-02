import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [BookItem] = []

    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                    // Search Bar in top area
                    SearchBar(searchText: $searchText, searchResults: $searchResults)
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

        }

    }

    private func performSearch(query: String) {
        // TODO: Implement actual search logic
        // For now, we'll create some mock data when searching
        if query.isEmpty {
            searchResults = []
        } else {
            // Mock search results
            searchResults = searchResults.filter { $0.bookBN.localizedCaseInsensitiveContains(query) || $0.authorBN.localizedCaseInsensitiveContains(query) }
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searchResults: [BookItem]

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
        // TODO: Implement actual search logic
        // For now, we'll create some mock data when searching
        if query.isEmpty {
            searchResults = []
        } else {
            // Mock search results
            searchResults = [].filter { $0.bookBN.localizedCaseInsensitiveContains(query) || $0.authorBN.localizedCaseInsensitiveContains(query) }
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
