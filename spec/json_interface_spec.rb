require 'spec_helper'

describe Mastermind::JSONInterface do
  before do
    @new_board = Mastermind::Board.new
    @new_board_structure = {:code=>nil, :rows=>[{:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}, {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}]}
  end

  describe '#generate_structure_from' do
    it "returns a data structure representation of a board object" do
      expect(Mastermind::JSONInterface.generate_structure_from(@new_board)).to eql(@new_board_structure)
    end
  end

  describe '#generate_board_from' do
    it "returns a board object from a data structure representation" do
      # Multiple expectations needed because objects that themselves contain objects 
      # (e.g., Board objects) cannot be usefully compared because their "subobjects"
      # have unique addresses in memory
      generated_board = Mastermind::JSONInterface.generate_board_from(@new_board_structure)
      expect(generated_board.code).to eql(@new_board.code)
      generated_board.rows.each_with_index do |row, index|
        expect(row.code_peg_holes).to eql(@new_board.rows[index].code_peg_holes)
        expect(row.key_peg_holes).to eql(@new_board.rows[index].key_peg_holes)
      end
    end
  end

  describe '#send_guess' do
    it "sets the code peg holes of the first non-empty row" do
      Mastermind::JSONInterface.send_guess(@new_board, [1, 1, 2, 2])
      expect(@new_board.rows[0].code_peg_holes).to eql([1, 1, 2, 2])
    end
  end
end
