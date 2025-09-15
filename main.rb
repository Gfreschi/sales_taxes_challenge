#!/usr/bin/env ruby
# frozen_string_literal: true

def exempt?(name)
  n = name.downcase
  n.include?('book') || n.include?('chocolate') || n.include?('pill')
end

def imported?(item)
  item.include?(:imported)
end

def round_tax(tax)
  ((tax * 20).ceil) / 20
end

def process_item(qty, name, imported, price)
  price = price.to_f
  basic_tax = exempt?(name) ? 0.0 : price * 0.1
  import_tax = imported == :imported ? price * 0.05 : 0.0

  tax = round_tax(basic_tax + import_tax)
  final_price = (price + tax) * qty

  puts "#{qty} #{name}: #{'%.2f' % final_price}"

  [tax * qty, final_price]
end

def process_receipt(inputs)
  total_tax = 0.0
  total = 0.0

  inputs.each do |item|
    qty, name, imported, price = item
    tax, price_total = process_item(qty, name, imported, price)
    total_tax += tax
    total += price_total
  end
  
  puts "Sales Taxes: #{'%.2f' % total_tax}"
  puts "Total: #{'%.2f' % total}"
  puts
end

input1 = [
  [2, "book", nil, 12.49],
  [1, "music CD", nil, 14.99],
  [1, "chocolate bar", nil, 0.85]
]
input2 = [
  [1, "box of chocolates", :imported, 10.00],
  [1, "bottle of perfume", :imported, 47.50]
]
input3 = [
  [1, "bottle of perfume", :imported, 27.99],
  [1, "bottle of perfume", nil, 18.99],
  [1, "packet of headache pills", nil, 9.75],
  [3, "boxes of chocolates", :imported, 11.25]
]

3.times do |i|
  process_receipt(eval("input#{i + 1}"))
end

# 2 book: 24.98
# 1 music CD: 15.99
# 1 chocolate bar: 0.85
# Sales Taxes: 1.00
# Total: 41.82

# 1 box of chocolates: 10.00
# 1 bottle of perfume: 54.50
# Sales Taxes: 7.00
# Total: 64.50

# 1 bottle of perfume: 31.99
# 1 bottle of perfume: 19.99
# 1 packet of headache pills: 9.75
# 3 boxes of chocolates: 33.75
# Sales Taxes: 5.00
# Total: 95.48
