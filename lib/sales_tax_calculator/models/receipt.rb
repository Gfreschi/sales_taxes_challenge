# frozen_string_literal: true

module SalesTaxCalculator
  class Receipt
    attr_reader :line_items, :total_sales_taxes, :total_cost

    def initialize
      @line_items = []
      @total_sales_taxes = Currency.new(0)
      @total_cost = Currency.new(0)
    end

    def add_item(product:, tax_amount:)
      final_price = product.total_base_price + tax_amount

      line_item = {
        product: product,
        tax_amount: tax_amount,
        final_price: final_price
      }

      @line_items << line_item
      @total_sales_taxes += tax_amount
      @total_cost += final_price

      nil
    end

    def to_s
      lines = []

      @line_items.each do |item|
        product = item[:product]
        final_price = item[:final_price]
        lines << "#{product.quantity} #{product.name}: #{final_price}"
      end

      lines << "Sales Taxes: #{@total_sales_taxes}"
      lines << "Total: #{@total_cost}"

      lines.join("\n")
    end

    def empty?
      @line_items.empty?
    end
  end
end
