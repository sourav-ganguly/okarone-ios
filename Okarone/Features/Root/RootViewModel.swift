//
//  RootViewModel.swift
//  Okarone
//
//  Created by Sourav on 13/7/25.
//
import SwiftUI

class RootViewModel: ObservableObject {
    @Published var tabs: [AppTab] = []
    private let tabProvider: AppTabProvider
    
    init(tabProvider: AppTabProvider = DefaultAppTabProvider()) {
        self.tabProvider = tabProvider
        self.tabs = tabProvider.getTabs()
    }
}
