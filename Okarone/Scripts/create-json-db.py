#!/usr/bin/env python3
"""
Script to read CSV data and create BookItem models
"""

import json
from typing import List
from dataclasses import dataclass, asdict
import csv
import os
import uuid

@dataclass
class BookItem:
    """Model representing a book item from the CSV file"""
    ID: str
    Book_EN: str
    Book_BN: str
    Author_EN: str
    Author_BN: str
    Publisher_EN: str
    Publisher_BN: str
    Stall_EN: str
    Stall_BN: str
    Direction_EN: str
    Direction_BN: str
    Block_EN: str
    Block_BN: str
    Duplicate: bool = False

def generate_unique_id() -> str:
    """Generate a unique UUID for each book item"""
    return str(uuid.uuid4())

def read_from_csv_file(file_path: str = "BookListDB.csv") -> List[BookItem]:
    """
    Read book data from a CSV file
    """
    book_items = []
    
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            csv_reader = csv.DictReader(file)
            for row in csv_reader:
                # Convert Duplicate field to boolean
                duplicate = row.get('Duplicate', '').lower() in ['true', '1', 'yes']
                
                book_item = BookItem(
                    ID=generate_unique_id(),  # Generate unique UUID for each item
                    Book_EN=row.get('Book_EN', ''),
                    Book_BN=row.get('Book_BN', ''),
                    Author_EN=row.get('Author_EN', ''),
                    Author_BN=row.get('Author_BN', ''),
                    Publisher_EN=row.get('Publisher_EN', ''),
                    Publisher_BN=row.get('Publisher_BN', ''),
                    Stall_EN=row.get('Stall_EN', ''),
                    Stall_BN=row.get('Stall_BN', ''),
                    Direction_EN=row.get('Direction_EN', ''),
                    Direction_BN=row.get('Direction_BN', ''),
                    Block_EN=row.get('Block_EN', ''),
                    Block_BN=row.get('Block_BN', ''),
                    Duplicate=duplicate
                )
                book_items.append(book_item)
        
        print(f"Successfully read {len(book_items)} books from {file_path}")
        return book_items
        
    except FileNotFoundError:
        print(f"CSV file not found: {file_path}")
        print("Falling back to sample data...")
        return read_sample_data()
    except Exception as e:
        print(f"Error reading CSV file: {e}")
        print("Falling back to sample data...")
        return read_sample_data()

def read_sample_data() -> List[BookItem]:
    """
    Read sample data for demonstration purposes
    """
    sample_data = [
        {
            "Book_EN": "Muhammad Nizam",
            "Book_BN": "মুহম্মদ নিজাম",
            "Author_EN": "Bayanna",
            "Author_BN": "৫২ (বায়ান্ন)",
            "Publisher_EN": "756",
            "Publisher_BN": "756",
            "Stall_EN": "Block E in map",
            "Stall_BN": "ম্যাপে ব্লক E তে",
            "Direction_EN": "E",
            "Direction_BN": "E",
            "Block_EN": "",
            "Block_BN": "",
            "Duplicate": False
        },
        {
            "Book_EN": "Ghulam Ashraf Khan is brilliant",
            "Book_BN": "গোলাম আশরাফ খান উজ্জ্বল",
            "Author_EN": "Bayanna",
            "Author_BN": "৫২ (বায়ান্ন)",
            "Publisher_EN": "756",
            "Publisher_BN": "756",
            "Stall_EN": "Block E in map",
            "Stall_BN": "ম্যাপে ব্লক E তে",
            "Direction_EN": "E",
            "Direction_BN": "E",
            "Block_EN": "",
            "Block_BN": "",
            "Duplicate": False
        },
        {
            "Book_EN": "Iftekhar Hossain Noor",
            "Book_BN": "ইফতেখার হোছাইন নূর",
            "Author_EN": "Bayanna",
            "Author_BN": "৫২ (বায়ান্ন)",
            "Publisher_EN": "756",
            "Publisher_BN": "756",
            "Stall_EN": "Block E in map",
            "Stall_BN": "ম্যাপে ব্লক E তে",
            "Direction_EN": "E",
            "Direction_BN": "E",
            "Block_EN": "",
            "Block_BN": "",
            "Duplicate": False
        },
        {
            "Book_EN": "Kazi Abu Taher",
            "Book_BN": "কাজী আবু তাহের",
            "Author_EN": "Bayanna",
            "Author_BN": "৫২ (বায়ান্ন)",
            "Publisher_EN": "756",
            "Publisher_BN": "756",
            "Stall_EN": "Block E in map",
            "Stall_BN": "ম্যাপে ব্লক E তে",
            "Direction_EN": "E",
            "Direction_BN": "E",
            "Block_EN": "",
            "Block_BN": "",
            "Duplicate": False
        },
        {
            "Book_EN": "Iftekhar Hossain Noor",
            "Book_BN": "ইফতেখার হোছাইন নূর",
            "Author_EN": "Bayanna",
            "Author_BN": "৫২ (বায়ান্ন)",
            "Publisher_EN": "756",
            "Publisher_BN": "756",
            "Stall_EN": "Block E in map",
            "Stall_BN": "ম্যাপে ব্লক E তে",
            "Direction_EN": "E",
            "Direction_BN": "E",
            "Block_EN": "",
            "Block_BN": "",
            "Duplicate": False
        }
    ]
    
    book_items = []
    for item_data in sample_data:
        # Add unique ID to each sample item
        item_data_with_id = {"ID": generate_unique_id(), **item_data}
        book_item = BookItem(**item_data_with_id)
        book_items.append(book_item)
    
    return book_items

def print_book_items(book_items: List[BookItem]):
    """Print the book items in a formatted way"""
    print(f"Total books found: {len(book_items)}")
    print("=" * 80)
    
    for i, book in enumerate(book_items, 1):
        print(f"Book {i}:")
        print(f"  ID: {book.ID}")
        print(f"  Book (EN): {book.Book_EN}")
        print(f"  Book (BN): {book.Book_BN}")
        print(f"  Author (EN): {book.Author_EN}")
        print(f"  Author (BN): {book.Author_BN}")
        print(f"  Publisher (EN): {book.Publisher_EN}")
        print(f"  Publisher (BN): {book.Publisher_BN}")
        print(f"  Stall (EN): {book.Stall_EN}")
        print(f"  Stall (BN): {book.Stall_BN}")
        print(f"  Direction (EN): {book.Direction_EN}")
        print(f"  Direction (BN): {book.Direction_BN}")
        print(f"  Block (EN): {book.Block_EN}")
        print(f"  Block (BN): {book.Block_BN}")
        print(f"  Duplicate: {book.Duplicate}")
        print("-" * 40)

def save_to_json(book_items: List[BookItem], output_file: str = "book_items.json"):
    """Save book items to a JSON file"""
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump([asdict(book) for book in book_items], f, ensure_ascii=False, indent=2)
        print(f"Data saved to {output_file}")
    except Exception as e:
        print(f"Error saving to JSON: {e}")

def main():
    """Main function to execute the script"""
    print("Reading CSV data from BookListDB.csv...")
    
    # Read data from CSV file
    book_items = read_from_csv_file("BookListDB.csv")
    
    # Print the data
    print_book_items(book_items)
    
    # Save to JSON file
    save_to_json(book_items)
    
    print("\nScript completed successfully!")

if __name__ == "__main__":
    main()
