module Mastermind
  module JSONInterface
    def self.generate_structure_from(board)
      board_structure = Hash.new
      board_structure.store(:code, board.code)
      rows_structure = generate_rows_structure_from(board)
      board_structure.store(:rows, rows_structure)
      board_structure
    end

    def self.generate_board_from(structure)
      board = Board.new
      board.set_code(structure[:code]) if structure[:code]
      set_rows(structure, board)
    end

    def self.send_guess(board, guess)
      retrieve_next_row(board).set_code_peg_holes(guess)
    end

    private

    def self.generate_rows_structure_from(board)
      rows_structure = Array.new
      board.rows.each do |row|
        row_structure = Hash.new
        row_structure.store(:code_peg_holes, row.code_peg_holes)
        row_structure.store(:key_peg_holes, row.key_peg_holes)
        rows_structure.push(row_structure)
      end
      rows_structure
    end

    def self.set_rows(structure, board)
      structure[:rows].each_with_index do |row, index|
        unless row_structure_empty?(row, :code_peg_holes)
          board.rows[index].set_code_peg_holes(row[:code_peg_holes])
        end
        unless row_structure_empty?(row, :key_peg_holes)
          board.rows[index].set_key_peg_holes(row[:key_peg_holes])
        end
      end
      board
    end

    def self.row_structure_empty?(row, holes)
      row[holes].all? { |hole| hole.nil? }
    end

    def self.retrieve_next_row(board)
      board.rows.each { |row| return row if row_empty? row }
    end

    def self.row_empty?(row)
      row.code_peg_holes.eql? Row.new.code_peg_holes
    end
  end
end
