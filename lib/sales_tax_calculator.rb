# frozen_string_literal: true

# Helpers
require_relative 'sales_tax_calculator/errors'

# Models
require_relative 'sales_tax_calculator/models/currency'
require_relative 'sales_tax_calculator/models/product'
require_relative 'sales_tax_calculator/models/line_item'
require_relative 'sales_tax_calculator/models/receipt'

# Policies
require_relative 'sales_tax_calculator/policies/product_classifier'
require_relative 'sales_tax_calculator/policies/tax_calculator'

# Services
require_relative 'sales_tax_calculator/services/input_parser'
require_relative 'sales_tax_calculator/services/receipt_generator'

module SalesTaxCalculator
  def self.generate_receipt(input)
    ReceiptGenerator.new.generate(input)
  end
end
