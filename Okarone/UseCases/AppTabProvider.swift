import Foundation

protocol AppTabProvider {
    func getTabs() -> [AppTab]
}

class DefaultAppTabProvider: AppTabProvider {
    func getTabs() -> [AppTab] {
        return [
            .bookstoreSearch,
            .okaroneFeed,
        ]
    }   
}