require 'spec_helper'

module Mastermind
  describe Board do

    it "is initialized with 10 Rows by default" do
      board = Board.new
      expect(board.rows).to have(10).things
    end

  end
end
