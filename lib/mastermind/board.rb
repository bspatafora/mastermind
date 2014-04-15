module Mastermind
  class Board
    attr_accessor :rows
    attr_reader :code

    def initialize(rows = 10, peg_holes = 4, code_pegs = (1..6))
      @rows = Array.new(rows) { Row.new() }
      @code = nil
      @peg_holes = peg_holes
      @code_pegs = code_pegs
    end

    def draw
      puts
      puts @code.map { |peg| "[#{peg}]" }.join(" ")
      24.times { print "_" }
      puts
      @rows.each do |row|
        print row.get_code_peg_holes.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
        print "  |  "
        print row.get_key_peg_holes.join
        puts
      end
      puts
    end

    def solicit_code
      print "Pick a #{@peg_holes} digit code (a digit may be between #{@code_pegs.first} and #{@code_pegs.last}): "
      set_code(gets.chomp)
    end

    def codebreaker_victory?
      @rows.any? { |row| row.get_code_peg_holes.eql? @code }
    end

    def codemaker_victory?
      unguessed = Row.new
      if @rows.any? { |row| row.get_code_peg_holes.eql? unguessed.get_code_peg_holes } || codebreaker_victory?
        false
      else
        true
      end
    end

    private

    def set_code(input)
      code = input.split('').map { |x| x.to_i }
      case check_code(code)
      when :valid
        @code = code
      when :invalid
        solicit_code
      when :preexisting_code
        raise ArgumentError, "Code has already been set this game."
      end
    end

    def check_code(code)
      valid_length = code.size == @peg_holes
      valid_digits = code.all? { |digit| @code_pegs.include? digit }
      if @code.nil? && valid_length && valid_digits
        return :valid
      elsif @code.nil?
        return :invalid
      else
        return :preexisting_code
      end
    end
  end
end
