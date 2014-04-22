module Mastermind
  class Board
    attr_reader :rows, :code

    def initialize
      @board_size = 10
      @row_size = 4
      @code_pegs = (1..6)
      @rows = Array.new(@board_size) { Row.new(size: @row_size, code_pegs: @code_pegs) }
    end

    def draw
      puts
      puts @code.map { |peg| "[#{peg}]" }.join(" ")
      24.times { print "_" }
      puts
      @rows.each do |row|
        print row.code_peg_holes.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
        print "  |  "
        print row.key_peg_holes.join
        puts
      end
      puts
    end

    def codebreaker_victory?
      @rows.any? { |row| row.code_peg_holes.eql? @code }
    end

    def codemaker_victory?
      !@rows.any? { |row| row.code_peg_holes.eql? Row.new.code_peg_holes } && !codebreaker_victory?
    end

    def solicit_code
      print "Pick a #{@row_size}-digit code (a digit may be between #{@code_pegs.first} and #{@code_pegs.last}): "
      set_code(gets.chomp)
    end

    private

    def set_code(input)
      code = input.split('').map { |x| x.to_i }
      if correct_length?(code) && all_valid?(code)
        @code = code
      else
        puts "Invalid code."
        solicit_code
      end
    end

    def correct_length?(code)
      code.size == @row_size
    end

    def all_valid?(code)
      code.all? { |peg| @code_pegs.include? peg }
    end
  end
end
