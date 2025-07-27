//
//  Item.swift
//  Okarone
//
//  Created by Sourav on 15/5/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
