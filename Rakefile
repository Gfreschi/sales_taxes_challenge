# frozen_string_literal: true

require 'rake/testtask'

desc 'Run test suite'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
desc 'Run fixture-based tests (usage: rake fixtures[filename] or FILE=input2.txt rake fixtures)'
task :fixtures, [:file] do |_, args|
  require_relative 'lib/sales_tax_calculator'

  fixtures = {
    'test_data/input1.txt' => <<~EXPECTED.chomp,
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    EXPECTED
    'test_data/input2.txt' => <<~EXPECTED.chomp,
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
      Sales Taxes: 7.65
      Total: 65.15
    EXPECTED
    'test_data/input3.txt' => <<~EXPECTED.chomp,
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      3 imported boxes of chocolates: 35.55
      Sales Taxes: 7.90
      Total: 98.38
    EXPECTED
  }

  target = args[:file] || ENV['FILE']
  selected_files = if target
    key = fixtures.keys.find { |k| File.basename(k) == File.basename(target) || k == target }
    unless key
      abort("Unknown fixture '#{target}'. Available fixtures: #{fixtures.keys.map { |k| File.basename(k) }.join(', ')}")
    end
    [key]
  else
    fixtures.keys
  end

  failures = []

  selected_files.each do |file_path|
    input = File.read(file_path)
    actual_output = SalesTaxCalculator.generate_receipt(input).to_s.strip
    expected_output = fixtures[file_path].strip

    if actual_output == expected_output
      puts "#{File.basename(file_path)}: PASS"
    else
      puts "#{File.basename(file_path)}: FAIL"
      puts "Expected:\n#{expected_output}\n\nActual:\n#{actual_output}\n\n"
      failures << file_path
    end
  end

  if failures.any?
    abort("Failed for: #{failures.map { |f| File.basename(f) }.join(', ')}")
  end
end
