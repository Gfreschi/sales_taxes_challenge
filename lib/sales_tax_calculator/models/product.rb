# frozen_string_literal: true

module SalesTaxCalculator
  class Product
    attr_reader :name, :unit_price, :quantity

    def initialize(name:, unit_price:, quantity: 1)
      @name = name.to_s.strip
      @unit_price = Currency.new(unit_price)
      @quantity = quantity.to_i

      validate!
      freeze
    end

    def total_base_price
      @unit_price * @quantity
    end

    def to_s
      "#{@quantity} #{@name} at #{@unit_price}"
    end

    private

    def validate!
      raise ArgumentError, "Name cannot be empty" if @name.empty?
      raise ArgumentError, "Unit price must be positive" if @unit_price.zero?
      raise ArgumentError, "Quantity must be positive" if @quantity <= 0
    end
  end
end
