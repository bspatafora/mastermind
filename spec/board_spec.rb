require 'spec_helper'

describe Mastermind::Board do
  before do
    @board = Mastermind::Board.new
    @board.set_code([1, 1, 1, 1])
  end

  describe '#initialize' do
    it "is initialized with 10 rows" do
      expect(@board.rows).to have(10).things
    end
  end

  describe "#set_code" do
    it "sets the code if it's valid" do
      expect(@board.code).to eql([1, 1, 1, 1])
    end

    it "doesn't set the code if it's invalid" do
      expect{ @board.set_code([1, 1, 1]) }.to raise_error(Mastermind::InvalidCode)
    end
  end

  describe "#codebreaker_victory?" do
    it "returns true when the code has been guessed" do
      @board.rows[0].set_code_peg_holes([1, 1, 1, 1])
      expect(@board.codebreaker_victory?).to be_true
    end

    it "returns false when the code hasn't been guessed" do
      expect(@board.codebreaker_victory?).to be_false
    end
  end

  describe "#codemaker_victory?" do
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
