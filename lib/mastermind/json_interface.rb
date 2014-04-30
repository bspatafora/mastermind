module Mastermind
  module JSONInterface
    def self.generate_structure_from(board)
      board_structure = Hash.new
      board_structure.store(:code, board.code)
      rows_set = Array.new
      board.rows.each do |row|
        row_set = Hash.new
        row_set.store(:code_peg_holes, row.code_peg_holes)
        row_set.store(:key_peg_holes, row.key_peg_holes)
        rows_set.push(row_set)
      end
      board_structure.store(:rows, rows_set)
      board_structure
    end

    def self.generate_board_from(structure)
      board = Board.new
      board.set_code(structure[:code]) if structure[:code]
      structure[:rows].each_with_index do |row, index|
        board.rows[index].set_code_peg_holes(row[:code_peg_holes]) if row[:code_peg_holes].all? { |x| !x.nil? }
        board.rows[index].set_key_peg_holes(row[:key_peg_holes]) if row[:key_peg_holes].all? { |x| !x.nil? }
      end
      board
    end

    def self.send_guess(board, guess)
      retrieve_next_row(board).set_code_peg_holes(guess)
    end

    private

    def self.retrieve_next_row(board)
      board.rows.each { |row| return row if row_empty? row }
    end

    def self.row_empty?(row)
      row.code_peg_holes.eql? Row.new.code_peg_holes
    end
  end
end
