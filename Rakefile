# frozen_string_literal: true

require 'rake/testtask'

desc 'Run unit tests'
Rake::TestTask.new(:unit) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: [:unit, :test]

desc 'Run acceptance tests'
task :test do
  puts 'Running acceptance tests...'

  test_cases = [
    {
      name: 'Test Case 1',
      input: "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85",
      expected: "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
    },
    {
      name: 'Test Case 2',
      input: "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50",
      expected: "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"
    },
    {
      name: 'Test Case 3',
      input: "1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25",
      expected: "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38"
    }
  ]

  require_relative 'lib/sales_tax_calculator'

  all_passed = true
  test_cases.each_with_index do |test_case, index|
    puts "\n#{test_case[:name]}:"
    puts "Input:\n#{test_case[:input]}"
    puts "\nExpected:\n#{test_case[:expected]}"

    begin
      actual = SalesTaxCalculator.generate_receipt(test_case[:input])
      output = actual.to_s
      puts "\nActual:\n#{output}"

      if output.strip == test_case[:expected].strip
        puts "PASSED"
      else
        puts "FAILED"
        all_passed = false
      end
    rescue => e
      puts "ERROR: #{e.message}"
      all_passed = false
    end

    puts '-' * 50
  end

  if all_passed
    puts "\nOK!"
    exit 0
  else
    puts "\nFAILED!"
    exit 1
  end
end
