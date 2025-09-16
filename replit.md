# Sales Tax Calculator - Quick Start

Click **Run** to start the interactive interface.

## Commands

- `tests` - Run challenge test cases (1, 2, or 3)
- `input` - Enter custom shopping items
- `help` - Show examples and rules
- `exit` - Quit application

## How to Use

### Test Cases
```
> tests
Enter choice (1-3): 1
```

### Custom Input
```
> input
Item: 1 book at 12.49
Item: 1 imported perfume at 47.50
Item: [Press Enter to calculate]
```

## Tax Rules

- **Basic Sales Tax**: 10% (exempt: books, food, medical)
- **Import Duty**: 5% on all imported goods
- **Rounding**: Up to nearest $0.05

## Input Format

Format: `quantity description at price`

Examples:
- `1 book at 12.49`
- `2 imported chocolates at 11.25`
- `1 packet of headache pills at 9.75`

## Features

- Precise BigDecimal calculations
- Automatic tax exemption detection
- Interactive CLI interface
