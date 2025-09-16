# frozen_string_literal: true

module SalesTaxCalculator
  class ReceiptGenerator
    def initialize(input_parser: InputParser.new)
      @input_parser = input_parser
    end

    def generate(input_text)
      products = @input_parser.parse(input_text)
      receipt = Receipt.new

      products.each do |product|
        tax_amount = TaxPolicy.calculate_tax_for(product)
        receipt.add_item(product: product, tax_amount: tax_amount)
      end

      receipt
    end
  end
end
