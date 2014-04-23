require 'spec_helper'

describe Mastermind::Game do
  it "should be playable" do
    board = Mastermind::Board.new
    interface = Mastermind::CommandLineInterface.new(board)
    game = Mastermind::Game.new(interface, board)
    interface.stub(:gets) { "1122" }
    expect(game.play).not_to raise_error
  end
end
