require 'spec_helper'

module Mastermind
  describe Board do

    it "is initialized with 10 rows by default" do
      board = Board.new
      expect(board.rows).to have(10).things
    end

    it "can be initialized with fewer rows" do
      board = Board.new(1)
      expect(board.rows).to have(1).things
    end

  end
end
