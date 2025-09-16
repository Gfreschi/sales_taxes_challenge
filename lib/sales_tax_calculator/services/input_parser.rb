# frozen_string_literal: true

module SalesTaxCalculator
  class InputParser
    INPUT_PATTERN = /\A(\d+)\s+(.+?)\s+at\s+(\d+\.\d{2})\z/i.freeze

    def parse(input_text)
      validate_input!(input_text)

      input_text.strip.split("\n").map.with_index(1) do |line, line_number|
        parse_line(line.strip, line_number)
      end
    end

    private

    def parse_line(line, line_number)
      match = line.match(INPUT_PATTERN)

      unless match
        raise InputParseError, "Invalid format at line #{line_number}: '#{line}'"
      end

      quantity = match[1].to_i
      name = match[2].strip
      unit_price = match[3]

      Product.new(name: name, unit_price: unit_price, quantity: quantity)
    rescue ArgumentError => e
      raise InputParseError, "Invalid data at line #{line_number}: #{e.message}"
    end

    def validate_input!(input_text)
      raise ArgumentError, "Input must be a string" unless input_text.is_a?(String)
      raise ArgumentError, "Input cannot be empty" if input_text.strip.empty?
    end
  end
end
