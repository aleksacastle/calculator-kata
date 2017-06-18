class Calculator
  ZERO = 0
  ONE = 1
  LIMIT = 1000
  ERROR = "negatives not allowed -".freeze

  def initialize; end

  def sum(numbers)
    initialize
    @numbers = numbers
    return ZERO if numbers.empty?
    numbers_to_int
    error_if_negative
    sum_calculate
  end

  private

  def choose_delimiter
    if @numbers.include?("//" && "[")
      delimiter_list = @numbers.scan(/\[.+?\]+?/).join("|")
      @delimiter = %r(#{delimiter_list})
    elsif @numbers.match(%r(\A//(.+)$))
      @delimiter = Regexp.last_match(ONE)
    else
      @delimiter = %r([,\n])
    end
  end

  def numbers_to_int
    choose_delimiter
    @args = @numbers.delete("//[]").split(@delimiter).
    map(&:to_i).reject {|num| num > LIMIT}
  end

  def error_if_negative
    negatives = @args.find_all { |n| n < ZERO }
    raise ArgumentError,
    ERROR+" #{negatives.join(", ")}" unless negatives.empty?
  end

  def sum_calculate
    @sum = @args.inject(ZERO) { |sum, number| sum + number }
  end
end
