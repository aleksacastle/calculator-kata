require 'spec_helper'
require 'variant3'

RSpec.describe Array do
  ERROR = "Group size must be a positive integer, was ".freeze
  ZERO = 0
  NEGATIVE_NUMBER = -3
  FALSE_FILL = false

  let(:list) { [1, 2, 3, 4, 5, 6] }

  describe '.in_groups_of' do
    it 'raises' do
      expect { list.in_groups_of(NEGATIVE_NUMBER, FALSE_FILL) }.
      to raise_error.with_message(ERROR+"#{NEGATIVE_NUMBER.inspect}")
    end
    it 'yields to the block multiple times' do
      expect {|b| list.in_groups_of(1,nil,&b) }
    .to yield_control.exactly(list.size).times
    end
    context "given nil as fill_with"
    it "returns [1, 2, 3, 4], [5, 6, nil, nil]" do
      expect(list.in_groups_of(4, nil)).to eql [[1, 2, 3, 4], [5, 6, nil, nil]]
    end
    context "no need for fill"
    it "returns list in groups" do
      expect(list.in_groups_of(3,nil)).to eql [[1, 2, 3], [4, 5, 6]]
    end
    context "there is no fill"
    it "returns list in groups" do
      expect(list.in_groups_of(4,FALSE_FILL)).to eql [[1, 2, 3, 4], [5, 6]]
    end
  end

  describe ".in_groups" do
    it 'yields to the block multiple times' do
      expect {|b| list.in_groups(list.size,nil,&b) }
    .to yield_control.exactly(list.size).times
    end
    context "given zero"
    it "raises" do
      expect {list.in_groups(ZERO, FALSE_FILL)}.to raise_error
    end
    context "given number less than list length"
    it "returns [1, 2], [3, 4], [5, 6]" do
      expect(list.in_groups(3, FALSE_FILL)).to eql [[1, 2], [3, 4], [5, 6]]
    end
    context "given number greater than list length with fill_with"
    it "returns" do
      expect(list.in_groups(7, nil)).to eql [[1], [2], [3], [4], [5], [6], [nil]]
    end
    it "returns" do
      expect(list.in_groups(7, false)).to eql [[1], [2], [3], [4], [5], [6], []]
    end
  end

  describe ".split" do
    context "given positive number"
    it "returns [2, 3, 4, 5, 6]" do
      expect(list.split(1)).to eql [[], [2, 3, 4, 5, 6]]
    end
    context "given zero"
    it "returns original" do
      expect(list.split(0)).to eql [list]
    end
  end
  it 'yields to the block multiple times' do
    expect {|b| list.split(list.size,&b) }
  .to yield_control.exactly(list.size).times
  end

  describe ".from" do
    it "returns [5, 6]" do
      expect(list.from(4)).to eql [5, 6]
    end
  end

  describe ".to" do
    context "given positive number"
    it "returns [1, 2, 3, 4]" do
      expect(list.to(3)).to eql [1, 2, 3, 4]
    end
    context "given negative number"
    it "returns [1, 2, 3, 4]" do
      expect(list.to(NEGATIVE_NUMBER)).to eql [1, 2, 3, 4]
    end
  end
end
