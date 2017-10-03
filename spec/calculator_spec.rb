require 'spec_helper'
require 'calculator'

RSpec.describe Calculator do
  describe ".sum" do
    describe "different input" do
      context "given empty string" do

        it "returns zero" do
          expect(subject.sum("")).to eql 0
        end
      end
      context "given normal numbers"

        it "returns 17" do
          expect(subject.sum("17")).to eql 17
        end

        it "5 plus 9 returns 14" do
          expect(subject.sum("5, 9")).to eql 14
        end

        it "1 plus 2 plus 3 returns 6" do
          expect(subject.sum("1, 2, 3")).to eql 6
        end
      end

    describe "delimiters" do

      it "supports new line as delimiter" do
        expect(subject.sum("1,\n2")).to eql 3
      end

      it "supports change of delimiters" do
        expect(subject.sum("//;\n1;2")).to eql 3
      end

      it "supports delimiters any length" do
        expect(subject.sum("//[***]\n1***2***3")).to eql 6
      end

      it "supports bunch delimiters" do
        expect(subject.sum("//[*][%]\n1*2%3")).to eql 6
      end
    end

    describe "limitations" do
      context "given one negative argument" do

        it "raises error" do
          negative_number = "-1"
          expect { subject.sum(negative_number) }.to raise_error(
          ArgumentError, "negatives not allowed - -1")
        end
      end
      context "given bunch of negative arguments" do

        it "raises error" do
          negative_numbers = "-1, 3, -5"
          expect{ subject.sum(negative_numbers) }.to raise_error(
          ArgumentError, "negatives not allowed - -1, -5")
        end
      end
      context "given number over 1000" do
        
        it "ignores" do
          expect(subject.sum("2, 1001")).to eql 2
        end
      end
    end
  end
end
