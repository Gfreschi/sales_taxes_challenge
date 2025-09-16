# frozen_string_literal: true

module SalesTaxCalculator
  class Product
    attr_reader :name, :unit_price, :quantity

    def initialize(name:, unit_price:, quantity: 1)
      @name = name.to_s.strip
      @unit_price = Currency.new(unit_price)
      @quantity = quantity.to_i
    end

    def total_base_price
      @unit_price * @quantity
    end

    def to_s
      "#{@quantity} #{@name} at #{@unit_price}"
    end
  end
end
