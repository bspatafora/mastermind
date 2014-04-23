require 'spec_helper'

describe Mastermind::CommandLineInterface do
  before do
    @board = Mastermind::Board.new
    @interface = Mastermind::CommandLineInterface.new(@board)
  end

  describe '#solicit_code' do
    it "solicits a code from the human player" do
      @interface.stub(:gets) { "1111" }
      expect(@interface.solicit_code).not_to raise_error
    end
  end

  describe '#solicit_feedback' do
    it "solicits feedback from the human player" do
      row = Mastermind::Row.new
      @interface.stub(:gets) { "11" }
      expect(@interface.solicit_feedback(row)).not_to raise_error
    end
  end

  describe '#draw_board' do
    it "draws the board" do
      @interface.stub(:gets) { "1111" }
      @interface.solicit_code
      expect(@interface.draw_board).not_to raise_error
    end
  end
end
