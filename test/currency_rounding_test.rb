# frozen_string_literal: true

require 'test_helper'

class CurrencyRoundingTest < Minitest::Test
  def test_round_up_examples
    # 1.125 -> 1.15
    c1 = SalesTaxCalculator::Currency.new('1.125').round_up
    assert_equal '1.15', c1.to_s

    # 0.5625 -> 0.60
    c2 = SalesTaxCalculator::Currency.new('0.5625').round_up
    assert_equal '0.60', c2.to_s

    # 0.05 -> 0.05
    c3 = SalesTaxCalculator::Currency.new('0.05').round_up
    assert_equal '0.05', c3.to_s
  end
end
