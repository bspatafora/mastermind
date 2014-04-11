module Mastermind
  class Row
    def initialize(peg_holes = 4, code_pegs = (1..6))
      @peg_holes = peg_holes
      @code_peg_holes = Array.new(peg_holes) { CodePegHole.new(code_pegs) }
      @key_peg_holes = Array.new(peg_holes) { KeyPegHole.new }
    end

    def get_guess
      get_row_group(@code_peg_holes)
    end

    def get_clues
      get_row_group(@key_peg_holes)
    end

    def set_guess(guess)
      if guess.size == @peg_holes
        guess.each_with_index { |peg, index| @code_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Guess input must consist of #{@peg_holes} things."
      end
    end

    def set_clues(clues)
      if clues.size <= @peg_holes
        clues.each_with_index { |peg, index| @key_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Clues input must consist of #{@peg_holes} or fewer things."
      end
    end

    private

    def get_row_group(group)
      group.map { |hole| hole.peg }
    end
  end
end
