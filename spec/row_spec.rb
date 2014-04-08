require 'spec_helper'

module Mastermind
  describe 'Row' do

    before { @row = Row.new }

    it "has 4 code peg holes" do
      expect(@row.get_guess).to have(4).things
    end

    it "has 4 key peg holes" do
      expect(@row.get_clues).to have(4).things
    end

    it "can have its code peg holes set" do
      @row.set_guess([1, 1, 1, 1])
      expect(@row.get_guess).to eql([1, 1, 1, 1])
    end

    it "can have its key peg holes set" do
      @row.set_clues([1, 1])
      expect(@row.get_clues).to eql([1, 1, nil, nil])
    end

    it "can't have too few code peg holes set" do
      expect { @row.set_guess([1, 1, 1]) }.to raise_error(ArgumentError)
    end

    it "can't have too many code peg holes set" do
      expect { @row.set_guess([1, 1, 1, 1, 1]) }.to raise_error(ArgumentError)
    end

    it "can't have too many key peg holes set" do
      expect { @row.set_clues([1, 1, 1, 1, 1]) }.to raise_error(ArgumentError)
    end
  end
end
