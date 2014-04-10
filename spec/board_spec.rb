require 'spec_helper'

module Mastermind
  describe Board do

    before { @board = Board.new }

    it "is initialized with 10 rows by default" do
      expect(@board.rows).to have(10).things
    end

    it "can be initialized with fewer rows" do
      board = Board.new(1)
      expect(board.rows).to have(1).things
    end

    it "can print a representation of itself" do
      expect(@board.draw).to have(10).things
    end

  end
end
