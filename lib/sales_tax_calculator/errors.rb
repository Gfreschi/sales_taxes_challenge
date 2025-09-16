# frozen_string_literal: true

module SalesTaxCalculator
  class Error < StandardError; end
  class InputParseError < Error; end
  class TaxCalculationError < Error; end
end
