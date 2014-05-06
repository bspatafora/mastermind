require 'spec_helper'

describe Mastermind::JSONInterface do
  before do
    @new_board = Mastermind::Board.new
    @new_board_structure = {:code => nil, :rows => generate_rows_structure}
  end

  describe '#generate_structure_from' do
    it "returns a data structure representation of a new board object" do
      expect(Mastermind::JSONInterface.generate_structure_from(@new_board)).to eql(@new_board_structure)
    end

    it "returns a data structure representation of an existing board object" do
      board = Mastermind::Board.new
      board.rows[0].set_code_peg_holes([1, 1, 2, 2])
      board.set_code([1, 2, 3, 4])

      rows_structure = generate_rows_structure
      rows_structure[0] = {:code_peg_holes=>[1, 1, 2, 2], :key_peg_holes=>[nil, nil, nil, nil]}
      board_structure = {:code=>[1, 2, 3, 4], :rows=>rows_structure}

      expect(Mastermind::JSONInterface.generate_structure_from(board)).to eql(board_structure)
    end
  end

  describe '#generate_board_from' do

    it "returns a board object from a new data structure representation" do
      generated_board = Mastermind::JSONInterface.generate_board_from(@new_board_structure)
      expect(board_match?(generated_board, @new_board)).to be_true
    end

    it "returns a board object from an existing data structure representation" do
      board = Mastermind::Board.new
      board.rows[0].set_code_peg_holes([1, 1, 2, 2])
      board.set_code([1, 2, 3, 4])

      rows_structure = generate_rows_structure
      rows_structure[0] = {:code_peg_holes=>[1, 1, 2, 2], :key_peg_holes=>[nil, nil, nil, nil]}
      board_structure = {:code=>[1, 2, 3, 4], :rows=>rows_structure}

      generated_board = Mastermind::JSONInterface.generate_board_from(board_structure)
      expect(board_match?(generated_board, board)).to be_true
    end
  end

  describe '#send_guess' do
    it "sets the code peg holes of the first non-empty row" do
      Mastermind::JSONInterface.send_guess(@new_board, [1, 1, 2, 2])
      expect(@new_board.rows[0].code_peg_holes).to eql([1, 1, 2, 2])
    end
  end

  def generate_rows_structure
    rows_structure = Array.new(@new_board.size) do
      {:code_peg_holes=>[nil, nil, nil, nil], :key_peg_holes=>[nil, nil, nil, nil]}
    end
  end

  def board_match?(generated_board, board)
    codes_equal = generated_board.code.eql? board.code
    rows_equal = true
    generated_board.rows.each_with_index do |row, index|
      rows_equal = false unless row.code_peg_holes.eql?(board.rows[index].code_peg_holes) &&
                                row.key_peg_holes.eql?(board.rows[index].key_peg_holes)
    end
    codes_equal && rows_equal
  end
end
