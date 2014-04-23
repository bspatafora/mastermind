module Mastermind
  class CommandLineInterface
    def initialize(board)
      @board = board
    end

    def solicit_code
      begin
        puts "Pick a #{@board.row_size}-digit code"
        puts "  Digits may be between #{@board.code_pegs.first} and #{@board.code_pegs.last}"
        print "Code: "
        @board.set_code(gets.chomp.split('').map { |digit| digit.to_i })
      rescue InvalidCode
        puts "Invalid code"
        solicit_code
      end
    end

    def solicit_feedback(row)
      begin
        puts "Provide feedback on the last guess"
        puts "  1 = correct number, correct position"
        puts "  2 = correct number, incorrect position"
        puts "  Example input: 122"
        print "Feedback: "
        row.set_key_peg_holes(gets.chomp.split('').map { |digit| digit.to_i })
      rescue TooManyPegs, InvalidPegs
        puts "Invalid feedback"
        solicit_feedback(row)
      end
    end

    def draw_board
      puts
      puts @board.code.map { |peg| "[#{peg}]" }.join(" ")
      24.times { print "_" }
      puts
      @board.rows.each do |row|
        print row.code_peg_holes.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
        print "  |  "
        print row.key_peg_holes.join
        puts
      end
      puts
    end

    def game_over
      if @board.codebreaker_victory?
        puts "Computer wins!"
      else
        puts "You win!"
      end
    end
  end
end

