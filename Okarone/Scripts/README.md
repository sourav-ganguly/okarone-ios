# CSV Data Reader

This script reads book data from a CSV file and converts it into structured `BookItem` models.

## Features

- Reads data from CSV files using Python's built-in csv module
- Creates structured `BookItem` models with all required fields
- Supports both English and Bengali text
- Exports data to JSON format
- Includes fallback to sample data if CSV file is not found

## BookItem Model Structure

```python
@dataclass
class BookItem:
    ID: str                    # Book ID
    Book_EN: str              # Book title in English
    Book_BN: str              # Book title in Bengali
    Author_EN: str            # Author name in English
    Author_BN: str            # Author name in Bengali
    Publisher_EN: str         # Publisher in English
    Publisher_BN: str         # Publisher in Bengali
    Stall_EN: str             # Stall information in English
    Stall_BN: str             # Stall information in Bengali
    Direction_EN: str         # Direction in English
    Direction_BN: str         # Direction in Bengali
    Block_EN: str             # Block information in English
    Block_BN: str             # Block information in Bengali
    Duplicate: bool = False   # Duplicate flag
```

## Setup Instructions

### 1. Prepare CSV File

Create a CSV file named `BookListDB.csv` in the same directory as the script with the following columns:

```csv
ID,Book_EN,Book_BN,Author_EN,Author_BN,Publisher_EN,Publisher_BN,Stall_EN,Stall_BN,Direction_EN,Direction_BN,Block_EN,Block_BN,Duplicate
```

### 2. Run the Script

```bash
python create-json-db.py
```

## Usage

The script will:

1. Attempt to read data from `BookListDB.csv`
2. Parse the data into `BookItem` objects
3. Print the data in a formatted way
4. Save the data to `book_items.json`

## Output

- **Console Output**: Formatted display of all book items
- **JSON File**: `book_items.json` containing all book data in structured format

## Fallback Behavior

If the CSV file is not found or cannot be read, the script will:

1. Use sample data based on the expected structure
2. Continue with the same output format
3. Provide informative messages about the fallback

## Sample Data

The script includes sample data from the original spreadsheet, including books like:
- অগ্নিমঙ্গল (Agni Mangal)
- অপরাজেয় বাংলা (Aporajeyo Bangla)
- অমাবস্যার ফুল আসো তোমায় চাঁদের গল্প বলি
- And more...

## File Structure

```
Scripts/
├── create-json-db.py      # Main script
├── requirements.txt       # Dependencies (none required)
├── README.md             # This file
├── BookListDB.csv        # Input CSV file (you need to create this)
└── book_items.json       # Output file (generated)
```

## CSV File Format

The CSV file should have the following structure:

```csv
ID,Book_EN,Book_BN,Author_EN,Author_BN,Publisher_EN,Publisher_BN,Stall_EN,Stall_BN,Direction_EN,Direction_BN,Block_EN,Block_BN,Duplicate
অগ্নিমঙ্গল,Muhammad Nizam,মুহম্মদ নিজাম,Bayanna,৫২ (বায়ান্ন),756,756,Block E in map,ম্যাপে ব্লক E তে,E,E,,,false
```

## Troubleshooting

### CSV File Issues

If you encounter issues with the CSV file:

1. Ensure `BookListDB.csv` is in the same directory as the script
2. Check that the CSV file has the correct column headers
3. Verify the file encoding is UTF-8
4. The script will fall back to sample data if the file cannot be read

### Dependencies

No external dependencies are required. The script uses only Python standard library modules:
- `json`
- `csv`
- `dataclasses`
- `typing`
- `os`

## Data Source

The script expects data from a CSV file that was originally exported from the Google Sheets document:
[BookList DB](https://docs.google.com/spreadsheets/d/1k8mIFDOiFGa_uV4QN4gcxpcU7MkhOqKZMDIO_MMDGpA/edit?gid=0#gid=0)

This spreadsheet contains book information for what appears to be a book fair or library catalog with both English and Bengali text. 