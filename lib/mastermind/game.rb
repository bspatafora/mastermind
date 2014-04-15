module Mastermind
  class Game
    def initialize
      @board = Board.new
      @computer = Computer.new
      @human = Human.new
    end

# CAN THIS BE TESTED?
    def play
      @board.solicit_code
      @board.rows.each do |row|
        row.set_code_peg_holes(@computer.solicit_guess(@board))
        @board.draw
        if @board.codebreaker_victory?
          puts "Computer wins!"
          break
        elsif @board.codemaker_victory?
          puts "You win!"
          break
        end
        row.set_key_peg_holes(@human.solicit_feedback)
      end
    end
  end
end
