# frozen_string_literal: true

require 'test_helper'
require 'open3'

class CLITest < Minitest::Test
  def test_cli_from_file
    out, err, status = Open3.capture3("exe/sales_tax_calculator", "test_data/input1.txt")
    assert status.success?, "expected exit 0, got #{status.exitstatus}, err=#{err}"
    expected = <<~OUT.strip
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    OUT
    assert_equal expected, out.strip
  end

  def test_cli_parse_error_exit_2
    _out, err, status = Open3.capture3("exe/sales_tax_calculator", stdin_data: "1 invalid line")
    refute status.success?
    assert_equal 2, status.exitstatus
    assert_match(/Parse error:/, err)
  end

  def test_cli_from_stdin_success
    input = "1 music CD at 14.99\n"
    out, err, status = Open3.capture3("exe/sales_tax_calculator", stdin_data: input)
    assert status.success?, "expected exit 0, got #{status.exitstatus}, err=#{err}"
    expected = <<~OUT.strip
      1 music CD: 16.49
      Sales Taxes: 1.50
      Total: 16.49
    OUT
    assert_equal expected, out.strip
  end
end
