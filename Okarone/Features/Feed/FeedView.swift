import SwiftUI

struct FeedView: View {
    // You can change this URL to any YouTube channel you prefer
    private let youtubeChannelURL = URL(string: "https://www.youtube.com/@Okarone1")!
    
    var body: some View {
        NavigationView {
            WebView(url: youtubeChannelURL)
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(Color.red)
        .ignoresSafeArea(.all, edges: .horizontal)
    }
}

#Preview {
    FeedView()
} 
