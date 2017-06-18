require 'test_helper'

class TestCalculator < Minitest::Test
  MAGIC_SUM = 99

  def setup
    @calc = Calculator.new
  end

  def test_sumEmptyString_returns_nil
    assert_equal(0, @calc.sum(""))
  end

  def test_sumOneNumber_returns_number
    sum_calculation("99")
  end

  def test_sumTwoNumbers_returns_number
    sum_calculation("9, 90")
  end

  def test_sumAnyNumbers_returns_sum
    sum_calculation("3, 6, 90")
  end

  def test_newLineAsComma
    sum_calculation("3\n6, 90")
  end

  def test_changingDelimiter
    sum_calculation("//;\n90;9")
  end

  def test_changingDelimiters_multiple
    sum_calculation("//[***]\n40***40***19")
  end

  def test_changingDelimiters_multiple_different
    sum_calculation("//[*][%]\n40*40%19")
  end

  def test_sum_raiseArgumentError_ifNegativeNumbers
    assert_raises(ArgumentError){sum_calculation("-3, 100")}
  end

  def test_sum_ignore1000andbigger
    refute_equal(1005, @calc.sum("1, 1004"))
    sum_calculation("99, 1005")
  end

  private
  def sum_calculation(numbers)
    assert_equal(MAGIC_SUM, @calc.sum(numbers))
  end
end
