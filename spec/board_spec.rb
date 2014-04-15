require 'spec_helper'

describe Mastermind::Board do
  before { @board = Mastermind::Board.new }

  describe '#initialize' do
    it "is initialized with 10 rows" do
      expect(@board.rows).to have(10).things
    end
  end

  describe '#draw' do
    it "can draw a representation of itself" do
      @board.stub(:gets) { "1111" }
      @board.solicit_code
      # BETTER WAY TO TEST THIS?
      expect(@board.draw).not_to raise_error
    end
  end

  describe "#solicit_code" do
    it "sets the code if it's valid" do
      @board.stub(:gets) { "1111" }
      @board.solicit_code
      expect(@board.code).to eql([1, 1, 1, 1])
    end

    it "doesn't set the code if it's invalid" do
      @board.stub(:gets).and_return("aaaa", "1111")
      @board.solicit_code
      expect(@board.code).to eql([1, 1, 1, 1])
    end

    it "doesn't set the code if it's already set" do
      @board.stub(:gets) { "1111" }
      @board.solicit_code
      expect { @board.solicit_code }.to raise_error(ArgumentError)
    end
  end

  describe "#codebreaker_victory?" do
    before(:each) do
      @board.stub(:gets) { "1111" }
      @board.solicit_code
    end

    it "returns true when the code has been guessed" do
      @board.rows[0].set_code_peg_holes([1, 1, 1, 1])
      expect(@board.codebreaker_victory?).to be_true
    end

    it "returns false when the code hasn't been guessed" do
      expect(@board.codebreaker_victory?).to be_false
    end
  end

  describe "#codemaker_victory?" do
    before(:each) do
      @board.stub(:gets) { "1111" }
      @board.solicit_code
    end

    it "returns true when game is over and code hasn't been guessed" do
      @board.rows.each { |row| row.set_code_peg_holes([2, 2, 2, 2]) }
      expect(@board.codemaker_victory?).to be_true
    end

    it "returns false if the game isn't over yet" do
      expect(@board.codemaker_victory?).to be_false
    end

    it "returns false if the code has been guessed" do
      @board.rows.each { |row| row.set_code_peg_holes([2, 2, 2, 2]) }
      @board.rows[9].set_code_peg_holes([1, 1, 1, 1])
      expect(@board.codemaker_victory?).to be_false
    end
  end
end
