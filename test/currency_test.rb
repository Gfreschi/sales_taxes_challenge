# frozen_string_literal: true

require 'test_helper'

class CurrencyTest < Minitest::Test
  def test_formats_two_decimal_places
    currency = SalesTaxCalculator::Currency.new(12.5)

    assert_equal '12.50', currency.to_s
  end
end
