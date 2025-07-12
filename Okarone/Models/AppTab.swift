import Foundation

enum AppTab: String, CaseIterable {
    case home = "Home"
    case bookstoreSearch = "Search"
    case okaroneFeed = "Feed"
    case readForToday = "Read"

    var label: String {
        switch self {
        case .home:
            return "Home"
        case .bookstoreSearch:
            return "Search"
        case .okaroneFeed:
            return "Feed"
        case .readForToday:
            return "Read"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .bookstoreSearch:
            return "magnifyingglass"
        case .okaroneFeed:
            return "list.bullet"
        case .readForToday:
            return "book.closed"
        }
    }
}