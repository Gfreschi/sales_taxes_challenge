# frozen_string_literal: true

require 'bigdecimal'

module SalesTaxCalculator
  # Currency value object for precise monetary calculations
  class Currency
    include Comparable

    attr_reader :cents

    def initialize(amount)
      decimal = BigDecimal(amount.to_s)
      @cents = (decimal * 100).round(0, BigDecimal::ROUND_HALF_UP).to_i
      freeze
    end

    def +(other)
      self.class.from_cents(@cents + other.cents)
    end

    def *(factor)
      if factor.is_a?(Integer)
        self.class.from_cents(@cents * factor)
      else
        scaled = BigDecimal(@cents) * BigDecimal(factor.to_s)
        self.class.from_cents(scaled.to_i)
      end
    end

    def round_up
      amount_cents = ((@cents + 4) / 5) * 5
      self.class.from_cents(amount_cents)
    end

    def to_s
      format('%.2f', @cents / 100.0)
    end

    def <=>(other)
      return nil unless other.is_a?(Currency)
      @cents <=> other.cents
    end

    def zero?
      @cents.zero?
    end

    private

    def self.from_cents(cents)
      obj = allocate
      obj.instance_variable_set(:@cents, cents.to_i)
      obj.freeze
      obj
    end
  end
end
