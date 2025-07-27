import Foundation

protocol GetAppTabsUseCase {
    func execute() -> [AppTab]
}

class GetAppTabsUseCaseImpl: GetAppTabsUseCase {
    func execute() -> [AppTab] {
        return [
            .bookstoreSearch,
            .okaroneFeed,
            .readForToday,
        ]
    }   
}
