require 'spec_helper'

describe Mastermind::Row do
  before {  @row = Mastermind::Row.new }

  describe '#initialize' do
    it "is initialized with 4 code peg holes by default" do
      expect(@row.code_peg_holes).to have(4).things
    end

    it "is initialized with 4 key peg holes by default" do
      expect(@row.key_peg_holes).to have(4).things
    end

    it "can be initialized with more code peg holes" do
      row = Mastermind::Row.new(size: 5)
      expect(row.code_peg_holes).to have(5).things
    end

    it "can be initialized with more key peg holes" do
      row = Mastermind::Row.new(size: 5)
      expect(row.key_peg_holes).to have(5).things
    end
  end

  describe '#set_code_peg_holes' do
    it "can have its code peg holes set" do
      @row.set_code_peg_holes([1, 1, 1, 1])
      expect(@row.code_peg_holes).to eql([1, 1, 1, 1])
    end
  end

  describe '#set_key_peg_holes' do
    it "can have its key peg holes set to valid input" do
      @row.set_key_peg_holes([1, 1])
      expect(@row.key_peg_holes).to eql([1, 1])
    end

    it "can't have more key peg holes set than the row's size" do
      row = Mastermind::Row.new(size: 2)
      expect { row.set_key_peg_holes([1, 1, 1]) }.to raise_error(Mastermind::TooManyPegs)
    end

    it "can't have its key peg holes set to invalid pegs" do
      expect { @row.set_key_peg_holes(['a']) }.to raise_error(Mastermind::InvalidPegs)
    end
  end
end
