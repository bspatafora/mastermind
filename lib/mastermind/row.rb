module Mastermind
  class Row
    attr_reader :code_peg_holes, :key_peg_holes

    def initialize(options = {})
      @code_pegs = options[:code_pegs] || (1..6)
      @key_pegs = (1..2)
      @row_size = options[:row_size] || 4
      @code_peg_holes = Array.new(@row_size)
      @key_peg_holes = Array.new(@row_size)
    end

    def set_code_peg_holes(pegs)
      pegs.each_with_index { |peg, index| @code_peg_holes[index] = peg }
    end

    def set_key_peg_holes(pegs)
      if !too_many?(pegs) && !any_invalid?(pegs)
        pegs.each_with_index { |peg, index| @key_peg_holes[index] = peg }
      elsif !any_invalid?(pegs)
        raise TooManyPegs, "Feedback must consist of #{@row_size} or fewer pegs."
      else
        raise InvalidPegs, "Valid key pegs are in range #{@key_pegs}"
      end
    end

    private

    def too_many?(pegs)
      pegs.size > @row_size
    end

    def any_invalid?(pegs)
      return true unless pegs.all? { |peg| @key_pegs.include? peg }
    end
  end
end
