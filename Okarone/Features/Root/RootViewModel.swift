//
//  RootViewModel.swift
//  Okarone
//
//  Created by Sourav on 13/7/25.
//
import SwiftUI

class RootViewModel: ObservableObject {
    @Published var tabs: [AppTab] = []
    private let getAppTabsUseCase: GetAppTabsUseCase
    
    init(getAppTabsUseCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl()) {
        self.getAppTabsUseCase = getAppTabsUseCase
        self.tabs = getAppTabsUseCase.execute()
    }
}
