require 'spec_helper'

describe Mastermind::CommandLineInterface do
  before do
    @board = Mastermind::Board.new
    @interface = Mastermind::CommandLineInterface.new(@board)
  end

  describe '#stringify_board' do
    it "stringifies the board" do
      board_string = <<eos

[1] [1] [1] [1]
________________________
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 
[ ] [ ] [ ] [ ] | 

eos
      @interface.stub(:gets) { "1111" }
      @interface.solicit_code
      expect(@interface.stringify_board).to eql(board_string)
    end
  end

  describe '#solicit_code' do
    it "solicits a code from the human player" do
      @interface.stub(:gets) { "1111" }
      @interface.solicit_code
      expect(@board.code).to eql([1, 1, 1, 1])
    end
  end

  describe '#solicit_feedback' do
    it "solicits feedback from the human player" do
      row = Mastermind::Row.new
      @interface.stub(:gets) { "11" }
      @interface.solicit_feedback(row)
      expect(row.key_peg_holes).to eql([1, 1])
    end
  end
end
