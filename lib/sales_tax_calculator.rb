# frozen_string_literal: true

# Load all components
require_relative "sales_tax_calculator/errors"
require_relative "sales_tax_calculator/models/currency"
require_relative "sales_tax_calculator/models/product"
require_relative "sales_tax_calculator/models/line_item"
require_relative "sales_tax_calculator/business/product_classifier"
require_relative "sales_tax_calculator/business/tax_policy"
require_relative "sales_tax_calculator/models/receipt"
require_relative "sales_tax_calculator/services/input_parser"
require_relative "sales_tax_calculator/services/receipt_generator"

module SalesTaxCalculator
  def self.generate_receipt(input)
    ReceiptGenerator.new.generate(input)
  end
end
