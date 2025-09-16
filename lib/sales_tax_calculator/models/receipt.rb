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
      validate_params!(product, tax_amount)

      final_price = product.total_base_price + tax_amount

      @line_items << LineItem.new(product: product, tax_amount: tax_amount, final_price: final_price)
      @total_sales_taxes += tax_amount
      @total_cost += final_price

      nil
    end

    def to_s
      lines = []

      @line_items.each { |item| lines << item.printable_line }

      lines << "Sales Taxes: #{@total_sales_taxes}"
      lines << "Total: #{@total_cost}"

      lines.join("\n")
    end

    def empty?
      @line_items.empty?
    end

    private

    def validate_params!(product, tax_amount)
      raise ArgumentError, "Expected Product" unless product.is_a?(Product)
      raise ArgumentError, "Expected Currency" unless tax_amount.is_a?(Currency)
      raise ArgumentError, "Tax cannot be negative" if tax_amount < Currency.new(0)
    end
  end
end
