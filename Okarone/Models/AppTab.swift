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
            return "খুঁজুন"
        case .okaroneFeed:
            return "আমাদের ভিডিও"
        case .readForToday:
            return "আজকে পড়ুন"
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