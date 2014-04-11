module Mastermind
  class Board
    attr_accessor :rows
    attr_reader :code

    def initialize(rows = 10)
      @rows = Array.new(rows) { Row.new }
      @code = nil
    end

    def draw
      puts
      puts @code.map { |peg| "[#{peg}]" }.join(" ")
      24.times { print "_" }
      puts
      @rows.each do |row|
        print row.get_guess.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
        print "  |  "
        print row.get_clues.join
        puts
      end
      puts
    end

    def solicit_code
      print "Pick a 4 digit code (a digit may be between 1 and 6): "
      set_code(gets.chomp)
    end

    def codebreaker_victory?
      @rows.any? { |row| row.get_guess.eql? @code }
    end

    def codemaker_victory?
      unguessed = Row.new
      if @rows.any? { |row| row.get_guess.eql? unguessed.get_guess } || codebreaker_victory?
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
      valid_length = code.size == 4
      # REFACTOR (1..6) SO IT CAN BE SET AND READ FROM ONE PLACE
      valid_digits = code.all? { |digit| (1..6).include? digit }
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
