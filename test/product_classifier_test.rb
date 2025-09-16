# frozen_string_literal: true

require 'test_helper'

class ProductClassifierTest < Minitest::Test
  def test_imported_detection_with_word_boundaries
    assert SalesTaxCalculator::ProductClassifier.imported?('imported bottle of perfume')
    refute SalesTaxCalculator::ProductClassifier.imported?('unimported bottle of perfume')
  end

  def test_tax_exempt_patterns
    assert SalesTaxCalculator::ProductClassifier.tax_exempt?('book')
    assert SalesTaxCalculator::ProductClassifier.tax_exempt?('chocolate bar')
    assert SalesTaxCalculator::ProductClassifier.tax_exempt?('box of chocolates')
    assert SalesTaxCalculator::ProductClassifier.tax_exempt?('medical pills')
  end

  def test_non_exempt_when_ambiguous_word
    refute SalesTaxCalculator::ProductClassifier.tax_exempt?('bar soap')
  end
end
