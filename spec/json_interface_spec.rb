require 'spec_helper'

describe Mastermind::JSONInterface do
  before do
    @new_board = Mastermind::Board.new
    @new_board_structure = create_new_board_structure
    @existing_board = create_existing_board
    @existing_board_structure = create_existing_board_structure
  end

  describe '#generate_structure_from' do
    it "returns a data structure representation of a new board object" do
      expect(Mastermind::JSONInterface.generate_structure_from(@new_board)).to eql(@new_board_structure)
    end

    it "returns a data structure representation of an existing board object" do
      expect(Mastermind::JSONInterface.generate_structure_from(@existing_board)).to eql(@existing_board_structure)
    end
  end

  describe '#generate_board_from' do

    it "returns a board object from a clean data structure representation" do
      generated_board = Mastermind::JSONInterface.generate_board_from(@new_board_structure)
      board_match?(generated_board, @new_board)
    end

    it "returns a board object from an existing data structure representation" do
      generated_board = Mastermind::JSONInterface.generate_board_from(@existing_board_structure)
      board_match?(generated_board, @existing_board)
    end
  end

  describe '#send_guess' do
    it "sets the code peg holes of the first non-empty row" do
      Mastermind::JSONInterface.send_guess(@new_board, [1, 1, 2, 2])
      expect(@new_board.rows[0].code_peg_holes).to eql([1, 1, 2, 2])
    end
  end

  def board_match?(generated_board, board)
      # Multiple expectations needed because objects that themselves contain objects 
      # (e.g., Board objects, which contain Row objects) cannot be usefully compared 
      # because their "subobjects" have unique addresses in memory
      expect(generated_board.code).to eql(board.code)
      generated_board.rows.each_with_index do |row, index|
        expect(row.code_peg_holes).to eql(board.rows[index].code_peg_holes)
        expect(row.key_peg_holes).to eql(board.rows[index].key_peg_holes)
      end
    end

  def create_new_board_structure
    rows_structure = generate_rows_structure
    structure = {:code=>nil, :rows=>rows_structure}
  end

  def create_existing_board
    board = Mastermind::Board.new
    board.set_code([1, 2, 3, 4])
    board.rows[0].set_code_peg_holes([1, 1, 2, 2])
    board
  end

  def create_existing_board_structure
    rows_structure = generate_rows_structure
    rows_structure[0] = {:code_peg_holes=>[1, 1, 2, 2], :key_peg_holes=>[nil, nil, nil, nil]}
    structure = {:code=>[1, 2, 3, 4], :rows=>rows_structure}
  end

  def generate_rows_structure
    rows_structure = Array.new(@new_board.size) do
      {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}
    end
  end
end
