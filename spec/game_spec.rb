require 'spec_helper'

describe Mastermind::Game do
  it "should be playable" do
    board = Mastermind::Board.new
    game = Mastermind::Game.new(board)
    board.stub(:gets) { "1122" }
    expect(game.play).not_to raise_error
  end
end
