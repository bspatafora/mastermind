require 'spec_helper'

describe Mastermind::Computer do
  before do
    @computer = Mastermind::Computer.new
    @board = Mastermind::Board.new
  end

  it "responds to solicit_guess with a guess" do
    expect(@computer.solicit_guess(@board)).to eql([1, 1, 2, 2])
  end

  it "generates the right number of codes given row size and possible code pegs" do
    expect(@computer.generate_all_codes).to have(1296).things
  end

  it "knows when it hasn't yet made any guesses" do
    expect(@computer.first_guess?(@board)).to be_true
  end

  it "knows when it has already made its first guess" do
    @board.rows.first.set_code_peg_holes([1, 1, 2, 2])
    expect(@computer.first_guess?(@board)).to be_false
  end

  describe "#solicit_feedback" do
    it "provides correct feedback for winning guesses" do
      expect(@computer.solicit_feedback([1, 1, 2, 2], [1, 1, 2, 2])).to eql([1, 1, 1, 1])
    end

    it "provides correct feedback for totally incorrect guesses" do
      expect(@computer.solicit_feedback([1, 1, 2, 2], [3, 3, 3, 3])).to eql([])
    end

    it "provides correct feedback for guesses with correct colors" do
      expect(@computer.solicit_feedback([1, 1, 2, 2], [2, 2, 3, 3])).to eql([2, 2])
    end

    it "provides correct feedback for guesses with correct positions" do
      expect(@computer.solicit_feedback([1, 1, 2, 2], [1, 1, 3, 3])).to eql([1, 1])
    end

    it "provides correct feedback in tricky instances" do
      expect(@computer.solicit_feedback([1, 1, 2, 2], [3, 3, 3, 1])).to eql([2])
    end
  end

  it "correctly eliminates remaining possible codes that cannot be the actual code" do
    expect(@computer.generate_codes_to_eliminate([1, 1, 2, 2], [1, 1, 1, 1])).to have(1295).things
  end

  it "generates the right number of feedbacks given row size" do
    expect(@computer.generate_all_feedbacks).to have(14).things
  end

  it "can determine the row of the last guess" do
    @board.rows[0].set_code_peg_holes([1, 1, 2, 2])
    @board.rows[1].set_code_peg_holes([3, 3, 3, 3])
    expect(@computer.determine_row_of_last_guess(@board)).to eql([3, 3, 3, 3])
  end
end
