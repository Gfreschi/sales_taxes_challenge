# frozen_string_literal: true

require 'test_helper'

class ParserBlankLinesTest < Minitest::Test
  def test_ignores_blank_lines_and_spaces
    input = "\n  2 book at 12.49\n\n1 music CD at 14.99  \n   \n1 chocolate bar at 0.85\n\n"
    receipt = SalesTaxCalculator.generate_receipt(input)
    expected = <<~TXT.strip
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    TXT
    assert_equal expected, receipt.to_s.strip
  end
end
