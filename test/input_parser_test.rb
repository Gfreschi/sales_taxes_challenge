# frozen_string_literal: true

require 'test_helper'

class InputParserTest < Minitest::Test
  def setup
    @parser = SalesTaxCalculator::InputParser.new
  end

  def test_parse_success
    products = @parser.parse("2 book at 12.49\n1 music CD at 14.99")
    assert_equal 2, products.size
    p1, p2 = products
    assert_equal 'book', p1.name
    assert_equal 2, p1.quantity
    assert_equal '12.49', p1.unit_price.to_s
    assert_equal 'music CD', p2.name
    assert_equal 1, p2.quantity
    assert_equal '14.99', p2.unit_price.to_s
  end

  def test_invalid_format_raises
    err = assert_raises(SalesTaxCalculator::InputParseError) do
      @parser.parse("1 invalid format line without price")
    end
    assert_match(/Invalid format/, err.message)
  end
end
