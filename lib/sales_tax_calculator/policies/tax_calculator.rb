# frozen_string_literal: true

module SalesTaxCalculator
  class TaxCalculator
    SALES_TAX_RATE = 0.10
    IMPORT_DUTY_RATE = 0.05

    class << self
      def calculate_for(product)
        unit_price = product.unit_price
        quantity = product.quantity

        total_rate = 0.0
        total_rate += SALES_TAX_RATE unless ProductClassifier.tax_exempt?(product.name)
        total_rate += IMPORT_DUTY_RATE if ProductClassifier.imported?(product.name)

        return Currency.new(0) if total_rate.zero?

        unit_tax = (unit_price * total_rate).round_up
        unit_tax * quantity
      end
    end
  end
end
