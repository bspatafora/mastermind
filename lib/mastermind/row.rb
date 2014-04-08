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
  end
end
