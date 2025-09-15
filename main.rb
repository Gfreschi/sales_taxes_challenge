#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bigdecimal'

class SalesTaxCalculator
  BASIC_TAX_RATE = 0.10
  IMPORT_TAX_RATE = 0.05
  ROUNDING_FACTOR = 20

  EXEMPT_KEYWORDS = %w[book chocolate pill].freeze

  attr_reader :total_tax, :total_amount

  def initialize
    reset!
  end

  def calculate_receipt(items)
    reset!
    items.map { |item| process_item(*item) }
  end

  private

  def process_item(qty, name, imported, price)
    unit_tax = calculate_unit_tax(name, imported, price)
    line_total = (price + unit_tax) * qty
    
    @total_tax += unit_tax * qty
    @total_amount += line_total
    
    { qty: qty, name: name, total: line_total }
  end

  def calculate_unit_tax(name, imported, price)
    basic_tax = exempt?(name) ? 0 : price * BASIC_TAX_RATE
    import_tax = imported ? price * IMPORT_TAX_RATE : 0
    round_tax(basic_tax + import_tax)
  end

  def exempt?(name)
    name_lower = name.downcase
    EXEMPT_KEYWORDS.any? { |keyword| name_lower.include?(keyword) }
  end

  def round_tax(tax)
    (BigDecimal(tax.to_s) * ROUNDING_FACTOR).ceil / ROUNDING_FACTOR
  end

  def reset!
    @total_tax = BigDecimal('0')
    @total_amount = BigDecimal('0')
  end
end

module ReceiptFormatter
  def self.print(items, total_tax, total_amount)
    items.each { |item| puts format_line(item) }
    puts "Sales Taxes: %.2f" % total_tax
    puts "Total: %.2f" % total_amount
    puts
  end
  
  private_class_method def self.format_line(item)
    "#{item[:qty]} #{item[:name]}: %.2f" % item[:total]
  end
end

class SalesTaxApp
  EXAMPLES = [
    [
      [2, "book", false, 12.49],
      [1, "music CD", false, 14.99],
      [1, "chocolate bar", false, 0.85]
    ],
    [
      [1, "box of chocolates", true, 10.00],
      [1, "bottle of perfume", true, 47.50]
    ],
    [
      [1, "bottle of perfume", true, 27.99],
      [1, "bottle of perfume", false, 18.99],
      [1, "packet of headache pills", false, 9.75],
      [3, "boxes of chocolates", true, 11.25]
    ]
  ].freeze

  def initialize
    @calculator = SalesTaxCalculator.new
    @cart = []
  end

  def run
    loop do
      show_menu
      choice = gets.chomp.to_i

      case choice
      when 1 then run_test_examples
      when 2 then add_items
      when 3 then generate_receipt
      when 4 then break
      else puts "Invalid option!"
      end
    end
  end

  private

  def show_menu
    puts "\nSales Tax Calculator"
    puts "1. Run test examples"
    puts "2. Add items"
    puts "3. Generate receipt"
    puts "4. Exit"
    print "Choose option: "
  end

  def run_test_examples
    EXAMPLES.each_with_index do |example, index|
      puts "\nExample #{index + 1}:"
      items = @calculator.calculate_receipt(example)
      ReceiptFormatter.print(items, @calculator.total_tax, @calculator.total_amount)
    end
  end

  def add_items
    loop do
      puts "\nAdd Item:"

      print "Quantity: "
      qty_input = gets.chomp
      break if qty_input.empty?

      qty = qty_input.to_i
      if qty <= 0
        puts "Invalid quantity!"
        next
      end

      print "Name: "
      name = gets.chomp.strip
      if name.empty?
        puts "Invalid name!"
        next
      end

      print "Imported? (y/n): "
      imported = gets.chomp.downcase.start_with?('y')

      print "Price: "
      price = gets.chomp.to_f
      if price < 0
        puts "Invalid price!"
        next
      end

      @cart << [qty, name, imported, price]
      puts "Item added!"
    end
  end

  def generate_receipt
    puts "\nCart is empty!" if @cart.empty?

    puts "\nYour Receipt:"
    items = @calculator.calculate_receipt(@cart)
    ReceiptFormatter.print(items, @calculator.total_tax, @calculator.total_amount)

    @cart.clear
    puts "Cart cleared."
  end
end

SalesTaxApp.new.run if __FILE__ == $PROGRAM_NAME
