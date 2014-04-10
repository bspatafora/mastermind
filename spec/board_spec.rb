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

    it "can draw a representation of itself" do
      expect(@board.draw).to have(10).things
    end

    describe "#solicit_code" do
      it "sets the code if it's valid" do
        @board.stub(:gets).and_return("1111")
        @board.solicit_code
        expect(@board.code).to eql([1, 1, 1, 1])
      end

      it "doesn't set the code if it's invalid" do
        @board.stub(:gets).and_return("aaaa", "1111")
        @board.solicit_code
        expect(@board.code).to eql([1, 1, 1, 1])
      end

      it "doesn't set the code if it's already set" do
        @board.stub(:gets).and_return("1111")
        @board.solicit_code
        expect { @board.solicit_code }.to raise_error(ArgumentError)
      end
    end

  end
end
