# Sales Tax Calculator

[![CI](https://github.com/Gfreschi/sales_taxes_challenge/workflows/CI/badge.svg)](https://github.com/Gfreschi/sales_taxes_challenge/actions)
[![Ruby Version](https://img.shields.io/badge/ruby-%3E%3D%202.7.0-red.svg)](https://ruby-lang.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Gfreschi/sales_taxes_challenge/pulls)

A Ruby application that calculates sales taxes and import duties for shopping receipts with precise decimal handling. This implementation addresses the classic Sales Taxes coding challenge, applying a 10% basic sales tax with exemptions for books, food, and medical products, plus a 5% import duty on all imported goods.

> Challenge reference: [HERE](https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36)

## 🚀 Try it Online

[![Run on Repl.it](https://img.shields.io/badge/run%20on-repl.it-667881.svg)](https://replit.com/@Gfreschi/salestaxeschallenge)

Click above for a fully configured environment. Test with: `ruby exe/sales_tax_calculator test_data/input1.txt`

## Tax Rules

**Basic Sales Tax**: 10% on all goods except books, food, and medical products.
**Import Duty**: 5% on all imported goods (no exemptions).
**Rounding**: Tax amounts rounded up to nearest $0.05.
**Calculation**: Per-unit tax calculation, then multiplied by quantity.
**Classification**: Case-insensitive keyword matching with word boundaries.

## Setup & Usage

**Requirements**: Ruby 2.7.0+, Minitest for tests

```bash
# Setup
bundle install
chmod +x exe/sales_tax_calculator

# File input
exe/sales_tax_calculator test_data/input1.txt

# STDIN input
echo "1 book at 12.49" | exe/sales_tax_calculator

# Interactive mode
exe/sales_tax_calculator
```

**Input Format**: `<quantity> <description> at <price>` with exactly 2 decimal places.

## Testing & Verification

```bash
rake test      # Full test suite
rake fixtures  # Validate against challenge cases
```

✅ **All three reference test cases pass** with correct tax calculations, rounding, and receipt formatting. Test coverage includes currency precision, classification rules, and end-to-end acceptance testing.

## Architecture

**Pipeline:** Input → Parse → Classify → Tax → Round → Receipt

![Architecture Flow](https://mermaid.ink/img/Zmxvd2NoYXJ0IExSCiAgICBBW/Cfk4QgSW5wdXRdIC0tPiBCW/Cfk50gUGFyc2VyXQogICAgQiAtLT4gQ3vwn5SNIENsYXNzaWZ5fQoKICAgIEMgLS0+IERb4p2MIEV4ZW1wdDxici8+MCVdCiAgICBDIC0tPiBFW/CfkrAgQmFzaWM8YnIvPjEwJV0KICAgIEMgLS0+IEZb8J+aoiBJbXBvcnQ8YnIvPis1JV0KCiAgICBEIC0tPiBHW/Cfp64gQ2FsY3VsYXRlXQogICAgRSAtLT4gRwogICAgRiAtLT4gRwoKICAgIEcgLS0+IEhb8J+UhCBSb3VuZDxici8+4oaRJDAuMDVdCiAgICBIIC0tPiBJW/Cfp74gUmVjZWlwdF0KCiAgICBjbGFzc0RlZiBpbnB1dCBmaWxsOiNlM2YyZmQsc3Ryb2tlOiMxOTc2ZDIsc3Ryb2tlLXdpZHRoOjNweAogICAgY2xhc3NEZWYgcHJvY2VzcyBmaWxsOiNmMWY4ZTksc3Ryb2tlOiM2ODlmMzgsc3Ryb2tlLXdpZHRoOjJweAogICAgY2xhc3NEZWYgZGVjaXNpb24gZmlsbDojZmZmM2UwLHN0cm9rZTojZjU3YzAwLHN0cm9rZS13aWR0aDoycHgKICAgIGNsYXNzRGVmIHRheCBmaWxsOiNmY2U0ZWMsc3Ryb2tlOiNjMjE4NWIsc3Ryb2tlLXdpZHRoOjJweAogICAgY2xhc3NEZWYgb3V0cHV0IGZpbGw6I2YzZTVmNSxzdHJva2U6IzdiMWZhMixzdHJva2Utd2lkdGg6M3B4CgogICAgY2xhc3MgQSBpbnB1dAogICAgY2xhc3MgQixHLEggcHJvY2VzcwogICAgY2xhc3MgQyBkZWNpc2lvbgogICAgY2xhc3MgRCxFLEYgdGF4CiAgICBjbGFzcyBJIG91dHB1dA==)

**Technical Decisions:**
• **BigDecimal**: Prevents floating-point errors in monetary calculations
• **Strategy Pattern**: TaxCalculator policies for extensible tax rules
• **Value Objects**: Immutable Currency/Product for thread safety
• **Per-unit calculation**: Accurate tax computation before quantity multiplication
• **Regex parsing**: Strict format validation with word boundaries
• **Ceiling rounding**: Matches real-world retail practices (↑$0.05)

## Limitations

- Input format must match exact specification
- English-only keyword classification
- Single currency, no internationalization
- Import detection via "imported" keyword only

## License

MIT License - see [LICENSE](LICENSE) file.

## Reference

[Original challenge specification](https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36)
