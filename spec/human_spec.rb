require 'spec_helper'

describe Mastermind::Human do
  describe "#solicit_feedback" do
    before do
      @human = Mastermind::Human.new
      @row = Mastermind::Row.new
    end

    it "sets the passed row's key peg holes if the user's input is valid" do
      @human.stub(:gets) { "11" }
    end

    it "doesn't accept too many pegs" do
      @human.stub(:gets).and_return("11111", "11")
    end

    it "doesn't accept invalid pegs" do
      @human.stub(:gets).and_return("aa", "11")
    end

    after do
      @human.solicit_feedback(@row)
      expect(@row.key_peg_holes).to eql([1, 1])
    end
  end
end
