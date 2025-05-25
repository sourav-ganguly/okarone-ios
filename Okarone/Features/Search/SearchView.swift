import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("appBg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all, edges: .top)

                Text("Search View")
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    SearchView()
} 
