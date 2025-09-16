# frozen_string_literal: true

require 'test_helper'

class ProductTest < Minitest::Test
  def test_negative_price_is_invalid
    assert_raises(ArgumentError) do
      SalesTaxCalculator::Product.new(name: 'music CD', unit_price: '-1.00', quantity: 1)
    end
  end

  def test_zero_price_is_invalid
    assert_raises(ArgumentError) do
      SalesTaxCalculator::Product.new(name: 'music CD', unit_price: '0.00', quantity: 1)
    end
  end
end
