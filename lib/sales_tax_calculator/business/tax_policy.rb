# frozen_string_literal: true

module SalesTaxCalculator
  class TaxPolicy
    SALES_TAX_RATE = 0.10
    IMPORT_DUTY_RATE = 0.05

    class << self
      def calculate_tax_for(product)
        base_price = product.total_base_price

        sales_tax = calculate_sales_tax(product, base_price)
        import_duty = calculate_import_duty(product, base_price)

        sales_tax + import_duty
      end

      private

      def calculate_sales_tax(product, base_price)
        return Currency.new(0) if ProductClassifier.tax_exempt?(product.name)

        raw_tax = base_price * SALES_TAX_RATE
        raw_tax.round_up
      end

      def calculate_import_duty(product, base_price)
        return Currency.new(0) unless ProductClassifier.imported?(product.name)

        raw_duty = base_price * IMPORT_DUTY_RATE
        raw_duty.round_up
      end
    end
  end
end
