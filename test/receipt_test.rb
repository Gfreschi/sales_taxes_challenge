# frozen_string_literal: true

require 'test_helper'

class ReceiptTest < Minitest::Test
  def test_printable_receipt
    input = "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"
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
