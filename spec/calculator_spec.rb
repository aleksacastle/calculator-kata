require 'spec_helper'
require 'calculator'

RSpec.describe Calculator do
  describe ".sum" do
    before(:each) do
      @calc = Calculator.new
    end
    # different input
    context "given empty string" do
      it "return zero" do
      expect(@calc.sum("")).to eql(0)
      end
    end
    context "given 17" do
      it "return 17" do
        expect(@calc.sum("17")).to eql(17)
      end
    end
    context "given '5, 9'" do
      it "return 14" do
      expect(@calc.sum("5, 9")).to eql(14)
      end
    end
    context "given '1, 2, 3'" do
      it "return 6" do
      expect(@calc.sum("1, 2, 3")).to eql(6)
      end
    end
    # delimiters
    it "supports new line as delimiter" do
      expect(@calc.sum("1,\n2")).to eql(3)
    end
    it "supports change of delimiters" do
      expect(@calc.sum("//;\n1;2")).to eql(3)
    end
    it "supports delimiters any length" do
      expect(@calc.sum("//[***]\n1***2***3")).to eql(6)
    end
    it "supports bunch delimiters" do
      expect(@calc.sum("//[*][%]\n1*2%3")).to eql(6)
    end
    # limitations
    context "given one negative argument" do
      it "raise error" do
        negative_number = "-1"
        expect{ @calc.sum(negative_number) }.to raise_error(
        ArgumentError, "negatives not allowed - -1")
      end
    end
    context "given bunch of negative arguments" do
      it "raise error" do
        negative_numbers = "-1, 3, -5"
        expect{ @calc.sum(negative_numbers) }.to raise_error(
        ArgumentError, "negatives not allowed - -1, -5")
      end
    end
    context "given number over 1000" do
      it "ignores" do
        expect(@calc.sum("2, 1001")).to eql(2)
      end
    end
  end
end
