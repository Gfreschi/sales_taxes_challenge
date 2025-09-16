# frozen_string_literal: true

module SalesTaxCalculator
  class ReceiptGenerator
    def initialize(input_parser: InputParser.new, tax_calculator: TaxCalculator)
      @input_parser = input_parser
      @tax_calculator = tax_calculator
    end

    def generate(input_text)
      products = @input_parser.parse(input_text)
      receipt = Receipt.new

      products.each do |product|
        tax_amount = @tax_calculator.calculate_for(product)
        receipt.add_item(product: product, tax_amount: tax_amount)
      end

      receipt
    end
  end
end
