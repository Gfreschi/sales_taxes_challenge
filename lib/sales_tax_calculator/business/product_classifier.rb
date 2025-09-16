# frozen_string_literal: true

module SalesTaxCalculator
  class ProductClassifier
    EXEMPT_CATEGORIES = %w[
      book books
      chocolate chocolates candy food bar
      pills medicine medical tablet tablets
    ].freeze

    def self.imported?(product_name)
      product_name.downcase.include?('imported')
    end

    def self.tax_exempt?(product_name)
      name_downcase = product_name.downcase
      EXEMPT_CATEGORIES.any? { |category| name_downcase.include?(category) }
    end
  end
end
