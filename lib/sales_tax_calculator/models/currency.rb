# frozen_string_literal: true

require 'bigdecimal'

module SalesTaxCalculator
  class Currency
    attr_reader :amount

    def initialize(value)
      @amount = BigDecimal(value.to_s)
    end

    def round_up_to_nickel
      return Currency.new(0) if amount.zero?
      Currency.new((amount * 20).ceil / BigDecimal('20'))
    end

    def zero?
      amount.zero?
    end

    def to_f
      amount.to_f
    end

    def to_s
      format('%.2f', amount)
    end
  end
end
