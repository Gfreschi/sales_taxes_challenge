#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/sales_tax_calculator'

def show_header
  puts "Sales Tax Calculator"
  puts "==================="
  puts "Commands: tests, input, help, exit"
  puts ""
end

def show_help
  puts "\nAvailable Commands:"
  puts "  tests  - Run challenge test cases (1, 2, or 3)"
  puts "  input  - Enter custom shopping items"
  puts "  help   - Show this help"
  puts "  exit   - Quit application"
  puts
  puts "Input format: 'quantity description at price'"
  puts "Examples:"
  puts "  1 book at 12.49"
  puts "  1 imported bottle of perfume at 47.50"
  puts "  1 packet of headache pills at 9.75"
  puts
  puts "In input mode:"
  puts "  - Enter items one per line"
  puts "  - Press Enter on empty line to calculate receipt"
  puts "  - Type 'exit' to return to main menu"
  puts
end

def run_test
  puts "\nSelect test case:"
  puts "  1 - Books, music, food"
  puts "  2 - Imported goods"
  puts "  3 - Mixed scenario"
  print "Enter choice (1-3): "
  
  choice = gets.chomp
  
  test_cases = {
    "1" => "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85",
    "2" => "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50",
    "3" => "1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25"
  }
  
  test_input = test_cases[choice]
  
  unless test_input
    puts "Invalid choice. Please select 1, 2, or 3."
    return
  end
  
  puts "\nTest Case #{choice}:"
  puts "Input:"
  test_input.each_line { |line| puts "  #{line}" }
  
  puts "\nResult:"
  puts "-" * 40
  
  begin
    receipt = SalesTaxCalculator.generate_receipt(test_input)
    puts receipt
  rescue => e
    puts "Error: #{e.message}"
  end
  
  puts "-" * 40
  puts ""
end

def input_mode
  puts "\nInput Mode - Enter shopping items:"
  puts "Enter items one per line. Press Enter on empty line to calculate."
  puts "Type 'exit' to return to main menu."
  puts ""
  
  items = []
  
  loop do
    print "Item: "
    line = gets.chomp

    if line.downcase == 'exit' || line.downcase == 'quit'
      break
    end

    if line.empty?
      if items.empty?
        puts "No items to calculate."
        next
      end
      
      puts "\nCalculating tax for #{items.length} item(s):"
      puts "-" * 40
      
      all_items = items.join("\n")
      
      begin
        receipt = SalesTaxCalculator.generate_receipt(all_items)
        puts receipt
      rescue SalesTaxCalculator::InputParseError => e
        puts "Parse error: #{e.message}"
      rescue => e
        puts "Error: #{e.message}"
      end
      
      puts "-" * 40
      puts "Receipt complete. Continue adding items or type 'exit'."
      puts ""

      items = []
      next
    end

    if line.match?(/^\d+\s+.+\s+at\s+\d+\.\d{2}$/)
      items << line
      puts "  Added: #{line}"
    else
      puts "  Invalid format. Use: 'quantity description at price'"
    end
  end
end

# Main program
show_header

loop do
  print "> "
  command = gets.chomp.downcase
  
  case command
  when 'tests', 'test', 't'
    run_test
    
  when 'input', 'i'
    input_mode
    
  when 'help', 'h'
    show_help
    
  when 'exit', 'quit', 'q'
    puts "Goodbye!"
    break
    
  when ''
    next
    
  else
    puts "Unknown command. Type 'help' for available commands."
  end
end
