module Mastermind
  class Row
    def initialize
      @code_peg_holes = Array.new(4) { CodePegHole.new }
      @key_peg_holes = Array.new(4) { KeyPegHole.new }
    end

    def get_guess
      @code_peg_holes.map { |hole| hole.peg }
    end

    def get_clues
      @key_peg_holes.map { |hole| hole.peg }
    end

    def set_guess(guess)
      if guess.size == 4
        guess.each_with_index { |peg, index| @code_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Guesses must consist of 4 things."
      end
    end

    def set_clues(clues)
      if clues.size <= 4
        clues.each_with_index { |peg, index| @key_peg_holes[index].set_peg(peg) }
      else
        raise ArgumentError, "Clues must consist of 4 things."
      end
    end
  end
end
