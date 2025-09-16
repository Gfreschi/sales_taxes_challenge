# frozen_string_literal: true

require 'test_helper'

class TaxCalculatorTest < Minitest::Test
  def build_product(name:, unit_price:, quantity: 1)
    SalesTaxCalculator::Product.new(name: name, unit_price: unit_price, quantity: quantity)
  end

  def test_imported_chocolates_three_units
    p = build_product(name: 'imported boxes of chocolates', unit_price: '11.25', quantity: 3)
    tax = SalesTaxCalculator::TaxCalculator.calculate_for(p)
    assert_equal '1.80', tax.to_s
  end

  def test_imported_perfume_one_unit
    p = build_product(name: 'imported bottle of perfume', unit_price: '27.99', quantity: 1)
    tax = SalesTaxCalculator::TaxCalculator.calculate_for(p)
    assert_equal '4.20', tax.to_s
  end
end
