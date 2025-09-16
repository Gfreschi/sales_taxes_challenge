# frozen_string_literal: true

require 'bigdecimal'

module SalesTaxCalculator
  # Currency value object for precise monetary calculations
  class Currency
    include Comparable

    attr_reader :cents

    def initialize(amount)
      @cents = (BigDecimal(amount.to_s) * 100).to_i
      freeze
    end

    def +(other)
      self.class.new((@cents + other.cents) / 100.0)
    end

    def *(factor)
      self.class.new(@cents * factor / 100.0)
    end

    def round_up
      amount_cents = (@cents.to_f / 5).ceil * 5
      self.class.new(amount_cents / 100.0)
    end

    def to_s
      format("%.2f", @cents / 100.0)
    end

    def <=>(other)
      return nil unless other.is_a?(Currency)
      @cents <=> other.cents
    end

    def zero?
      @cents.zero?
    end
  end
end
