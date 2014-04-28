require 'spec_helper'

describe Mastermind::CommandLineRunner do
  before do
    @board = Mastermind::Board.new
    @interface = Mastermind::CommandLineInterface.new(@board)
    @computer = Mastermind::Computer.new(@board)
    @game = Mastermind::CommandLineRunner.new(@interface, @board, @computer)
  end

  describe '#play' do
    it "runs until the game is over" do
      @interface.stub(:gets) { "1111" }
      @computer.stub(:solicit_guess) { [1, 1, 2, 2] }
      expect(@interface).to receive(:say_game_over)
      @game.play
    end
  end
end
