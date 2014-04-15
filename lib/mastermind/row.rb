module Mastermind
  class Row
    def initialize(peg_holes = 4, code_pegs = (1..6))
      @peg_holes = peg_holes
      @code_peg_holes = Array.new(peg_holes) { CodePegHole.new(code_pegs) }
      @key_peg_holes = Array.new(peg_holes) { KeyPegHole.new }
    end

    def set_code_peg_holes(pegs)
      if pegs.size == @peg_holes
        pegs.each_with_index { |peg, index| @code_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Guess input must consist of #{@peg_holes} things."
      end
    end

    def set_key_peg_holes(pegs)
      if pegs.size <= @peg_holes
        pegs.each_with_index { |peg, index| @key_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Clues input must consist of #{@peg_holes} or fewer things."
      end
    end

    def get_code_peg_holes
      get_row_group(@code_peg_holes)
    end

    def get_key_peg_holes
      get_row_group(@key_peg_holes)
    end

    private

    def get_row_group(group)
      group.map { |hole| hole.peg }
    end
  end
end
