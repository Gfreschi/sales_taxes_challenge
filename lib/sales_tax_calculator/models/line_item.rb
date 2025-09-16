# frozen_string_literal: true

module SalesTaxCalculator
  class LineItem
    attr_reader :product, :tax_amount, :final_price

    def initialize(product:, tax_amount:, final_price:)
      @product = product
      @tax_amount = tax_amount
      @final_price = final_price
      freeze
    end

    def printable_line
      "#{product.quantity} #{product.name}: #{final_price}"
    end
  end
end
