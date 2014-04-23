module Mastermind
  class Board
    attr_reader :row_size, :code_pegs, :rows, :code

    def initialize
      @board_size = 10
      @row_size = 4
      @code_pegs = (1..6)
      @rows = Array.new(@board_size) { Row.new(size: @row_size, code_pegs: @code_pegs) }
    end

    def codebreaker_victory?
      @rows.any? { |row| row.code_peg_holes.eql? @code }
    end

    def codemaker_victory?
      !@rows.any? { |row| row.code_peg_holes.eql? Row.new.code_peg_holes } && !codebreaker_victory?
    end

    def set_code(code)
      if correct_length?(code) && all_valid?(code)
        @code = code
      else
        raise InvalidCode
      end
    end

    private

    def correct_length?(code)
      code.size == @row_size
    end

    def all_valid?(code)
      code.all? { |peg| @code_pegs.include? peg }
    end
  end
end
