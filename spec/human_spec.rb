require 'spec_helper'

describe Mastermind::Human do
  describe "#solicit_clues" do
    before { @human = Mastermind::Human.new }

    it "returns a clue array if the user's input is valid" do
      @human.stub(:gets) { "11" }
      expect(@human.solicit_clues).to eql([1, 1])
    end

    it "doesn't accept invalid codes" do
      @human.stub(:gets).and_return("aa", "11")
      expect(@human.solicit_clues).to eql([1, 1])
    end
  end
end
