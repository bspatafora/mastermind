module Mastermind
  class CommandLineRunner
    def initialize(interface, board, computer)
      @board = board
      @interface = interface
      @computer = computer
    end

    def play
      @interface.solicit_code
      @board.rows.each do |row|
        row.set_code_peg_holes(@computer.solicit_guess)
        @interface.draw_board
        if game_over?
          @interface.say_game_over(determine_winner)
          break
        end
        @interface.solicit_feedback(row)
      end
    end

    private

    def game_over?
      @board.codebreaker_victory? || @board.codemaker_victory?
    end

    def determine_winner
      if @board.codebreaker_victory?
        "Computer"
      else
        "Human"
      end
    end
  end
end
