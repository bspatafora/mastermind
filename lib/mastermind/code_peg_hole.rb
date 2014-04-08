module Mastermind
  class CodePegHole
    attr_reader :peg

    @@code_pegs = (1..6)

    def initialize
      @peg = nil
    end

    def set_peg(peg)
      if @@code_pegs.include?(peg)
        @peg = peg
      else
        raise ArgumentError, "#{peg} is not a valid code peg."
      end
    end
  end
end
