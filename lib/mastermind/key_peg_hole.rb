module Mastermind
  class KeyPegHole
    attr_reader :peg

    @@key_pegs = (1..2)

    def initialize
      @peg = nil
    end

    def set_peg(peg)
      if @@key_pegs.include?(peg)
        @peg = peg
      else
        raise ArgumentError, "#{peg} is not a valid key peg."
      end
    end
  end
end
