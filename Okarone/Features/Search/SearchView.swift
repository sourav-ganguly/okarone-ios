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
                            .ignoresSafeArea(.all, edges: .top)
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
            searchResults = [
                BookItem(id: "1", title: "Sample Book 1", author: "Author 1", coverURL: nil),
                BookItem(id: "2", title: "Sample Book 2", author: "Author 2", coverURL: nil),
                BookItem(id: "3", title: "Sample Book 3", author: "Author 3", coverURL: nil)
            ].filter { $0.title.localizedCaseInsensitiveContains(query) || $0.author.localizedCaseInsensitiveContains(query) }
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
            searchResults = [
                BookItem(id: "1", title: "Sample Book 1", author: "Author 1", coverURL: nil),
                BookItem(id: "2", title: "Sample Book 2", author: "Author 2", coverURL: nil),
                BookItem(id: "3", title: "Sample Book 3", author: "Author 3", coverURL: nil)
            ].filter { $0.title.localizedCaseInsensitiveContains(query) || $0.author.localizedCaseInsensitiveContains(query) }
        }
    }
}

struct SearchResultContainerView: View {
    @Binding var searchResults: [BookItem]
    
    var body: some View {
        VStack(spacing: 0) {
            if !searchResults.isEmpty {
                List(searchResults) { book in
                    BookItemRow(book: book)
                        .listRowBackground(Color.car)
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
            
            Spacer()
        }
    }
}

#Preview {
    RootView()
}
