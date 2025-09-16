# frozen_string_literal: true

module SalesTaxCalculator
  class ProductClassifier
    EXEMPT_PATTERNS = [
      /\bbook(s)?\b/i,
      /\bchocolate bar\b/i,
      /\b(box|boxes) of chocolates\b/i,
      /\bchocolate(s)?\b/i,
      /\b(pill|pills|tablet|tablets)\b/i,
      /\b(headache|medicine|medical)\b/i
    ].freeze

    def self.imported?(product_name)
      /\bimported\b/i.match?(product_name)
    end

    def self.tax_exempt?(product_name)
      EXEMPT_PATTERNS.any? { |rx| rx.match?(product_name) }
    end
  end
end
