require 'spec_helper'

describe Mastermind::Computer do
  it "correctly guesses" do
    board = Mastermind::Board.new
    computer = Mastermind::Computer.new(board)
    board.rows.first.set_code_peg_holes([1, 1, 2, 2])
    board.rows.first.set_key_peg_holes([])
    expect(computer.solicit_guess).to eql([3, 3, 4, 5])
  end
end
