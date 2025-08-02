//
//  BookDetailView.swift
//  Okarone
//
//  Created by Sourav on 15/5/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: SearchResultItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with book title
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.bookEN)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(book.bookBN)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 10)
                
                // Author information
                DetailSection(
                    title: "Author / লেখক",
                    englishText: book.authorEN,
                    bengaliText: book.authorBN
                )
                
                // Publisher information
                DetailSection(
                    title: "Publisher / প্রকাশক",
                    englishText: book.publisherEN,
                    bengaliText: book.publisherBN
                )
                
                // Location information
                VStack(alignment: .leading, spacing: 16) {
                    Text("Location / অবস্থান")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        // Stall information
                        LocationDetailRow(
                            icon: "building.2",
                            title: "Stall / স্টল",
                            englishText: book.stallEN,
                            bengaliText: book.stallBN
                        )
                        
                        // Block information
                        LocationDetailRow(
                            icon: "square.grid.3x3",
                            title: "Block / ব্লক",
                            englishText: book.blockEN,
                            bengaliText: book.blockBN
                        )
                        
                        // Direction information
                        LocationDetailRow(
                            icon: "location",
                            title: "Direction / দিকনির্দেশনা",
                            englishText: book.directionEN,
                            bengaliText: book.directionBN
                        )
                    }
                }
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Supporting Views

struct DetailSection: View {
    let title: String
    let englishText: String
    let bengaliText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(englishText)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Text(bengaliText)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
        }
    }
}

struct LocationDetailRow: View {
    let icon: String
    let title: String
    let englishText: String
    let bengaliText: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(englishText)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Text(bengaliText)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        BookDetailView(book: SearchResultItem(
            id: "1",
            bookEN: "The Great Gatsby",
            bookBN: "দ্য গ্রেট গ্যাটসবি",
            authorEN: "F. Scott Fitzgerald",
            authorBN: "এফ. স্কট ফিটজগারাল্ড",
            publisherEN: "Scribner",
            publisherBN: "স্ক্রিবনার",
            stallEN: "Stall A-15",
            stallBN: "স্টল এ-১৫",
            directionEN: "Near the main entrance, turn left",
            directionBN: "মূল প্রবেশপথের কাছে, বাম দিকে ঘুরুন",
            blockEN: "Block B",
            blockBN: "ব্লক বি"
        ))
    }
} 