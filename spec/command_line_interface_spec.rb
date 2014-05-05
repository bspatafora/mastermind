require 'spec_helper'

describe Mastermind::CommandLineInterface do
  before do
    @board = Mastermind::Board.new
    @board.set_code([1, 1, 1, 1])
    @interface = Mastermind::CommandLineInterface.new(@board)
  end

  describe '#send_code' do
    it "sends the solicited code to the board" do
      @interface.send_code("1111")
      expect(@board.code).to eql([1, 1, 1, 1])
    end
  end

  describe '#send_feedback' do
    it "sends the solicited feedback to the row" do
      row = Mastermind::Row.new
      @interface.send_feedback("11", row)
      expect(row.key_peg_holes).to eql([1, 1])
    end
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
      expect(@interface.stringify_board).to eql(board_string)
    end
  end
end
