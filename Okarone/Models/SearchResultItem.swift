//
//  SearchResultItem.swift
//  Okarone
//
//  Created by Sourav on 15/5/25.
//

import Foundation

struct SearchResultItem: Identifiable, Codable {
    let id: String
    let bookEN: String
    let bookBN: String
    let authorEN: String
    let authorBN: String
    let publisherEN: String
    let publisherBN: String
    let stallEN: String
    let stallBN: String
    let directionEN: String
    let directionBN: String
    let blockEN: String
    let blockBN: String
    
    init(id: String, 
         bookEN: String, 
         bookBN: String, 
         authorEN: String, 
         authorBN: String, 
         publisherEN: String, 
         publisherBN: String, 
         stallEN: String, 
         stallBN: String, 
         directionEN: String, 
         directionBN: String, 
         blockEN: String, 
         blockBN: String) {
        self.id = id
        self.bookEN = bookEN
        self.bookBN = bookBN
        self.authorEN = authorEN
        self.authorBN = authorBN
        self.publisherEN = publisherEN
        self.publisherBN = publisherBN
        self.stallEN = stallEN
        self.stallBN = stallBN
        self.directionEN = directionEN
        self.directionBN = directionBN
        self.blockEN = blockEN
        self.blockBN = blockBN
    }
} 