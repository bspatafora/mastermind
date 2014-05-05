require 'spec_helper'

describe Mastermind::CommandLineRunner do
  before do
    @board = Mastermind::Board.new
    @interface = double("Command line interface",
                        :solicit_code => "1111",
                        :solicit_feedback => "",
                        :draw_board => nil)
    @computer = double("Computer", :solicit_guess => [1, 1, 2, 2])
    @game = Mastermind::CommandLineRunner.new(@interface, @board, @computer)
  end

  describe '#play' do
    it "runs until the game is over" do
      expect(@interface).to receive(:say_game_over)
      @game.play
    end
  end
end
