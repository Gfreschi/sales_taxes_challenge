# frozen_string_literal: true

require 'test_helper'

class RandomPropertyTest < Minitest::Test
  EXEMPT = [
    'book',
    'box of chocolates',
    'chocolate bar',
    'pills',
  ].freeze

  NON_EXEMPT = [
    'music CD',
    'bottle of perfume',
    'packet of cookies',
    'video game',
  ].freeze

  def setup
    srand(12_345)
    @parser = SalesTaxCalculator::InputParser.new
  end

  def test_receipt_properties_hold_for_random_inputs
    30.times do
      input = build_random_input(rand(1..5))

      receipt = SalesTaxCalculator.generate_receipt(input)
      products = @parser.parse(input)

      taxes = SalesTaxCalculator::Currency.new('0')
      total = SalesTaxCalculator::Currency.new('0')
      expected_lines = []

      products.each do |p|
        tax = SalesTaxCalculator::TaxCalculator.calculate_for(p)
        final = p.total_base_price + tax
        taxes += tax
        total += final
        expected_lines << "#{p.quantity} #{p.name}: #{final}"
      end

      expected_lines << "Sales Taxes: #{taxes}"
      expected_lines << "Total: #{total}"

      assert_equal expected_lines.join("\n").strip, receipt.to_s.strip

      assert (taxes.cents % 5).zero?, 'Sales taxes must be multiple of $0.05'
    end
  end

  private

  def build_random_input(n)
    lines = Array.new(n) { build_random_line }
    with_blanks = []
    lines.each do |ln|
      with_blanks << (rand < 0.2 ? '' : nil)
      with_blanks << ln
    end
    with_blanks.compact.join("\n")
  end

  def build_random_line
    qty = rand(1..5)
    imported = (rand < 0.5)
    name = (EXEMPT + NON_EXEMPT).sample.dup
    name = "imported #{name}" if imported
    price_cents = rand(50..200_00) # 0.50 .. 200.00
    price = format('%.2f', price_cents / 100.0)
    "#{qty} #{name} at #{price}"
  end
end
