module Mastermind
  class Game
    def initialize
      @board = Board.new
      @computer = Computer.new
      @human = Human.new
    end

    def play
      @board.solicit_code
      @board.rows.each do |row|
        row.set_guess(@computer.solicit_guess(@board))
        @board.draw
        if @board.codebreaker_victory?
          puts "Computer wins!"
          break
        elsif @board.codemaker_victory?
          puts "You win!"
          break
        end
        row.set_clues(@human.solicit_clues)
      end
    end
  end
end