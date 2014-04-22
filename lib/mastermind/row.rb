module Mastermind
  class Row
    attr_reader :code_peg_holes, :key_peg_holes

    def initialize(options = {})
      @code_pegs = (1..6)
      @key_pegs = (1..2)
      @size = options[:size] || 4
      @code_peg_holes = Array.new(@size)
      @key_peg_holes = Array.new(@size)
    end

    def set_code_peg_holes(pegs)
      set_peg_holes(pegs, @code_peg_holes)
    end

    def set_key_peg_holes(pegs)
      if too_many?(pegs)
        raise TooManyPegs, "Feedback must consist of #{@size} or fewer pegs."
      elsif any_invalid?(pegs)
        raise InvalidPegs, "Valid key pegs are in range #{@key_pegs}"
      else
        set_peg_holes(pegs, @key_peg_holes)
      end
    end

    private

    def set_peg_holes(pegs, holes)
      holes.replace(pegs)
    end

    def too_many?(pegs)
      pegs.size > @size
    end

    def any_invalid?(pegs)
      !pegs.all? { |peg| @key_pegs.include? peg }
    end
  end
end
