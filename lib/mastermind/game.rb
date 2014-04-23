module Mastermind
  class Game
    def initialize(interface, board)
      @board = board
      @interface = interface
      @computer = Computer.new(@board)
    end

    def play
      @interface.solicit_code
      @board.rows.each do |row|
        row.set_code_peg_holes(@computer.solicit_guess)
        @interface.draw_board
        if @board.codebreaker_victory? || @board.codemaker_victory?
          @interface.game_over
          break
        end
        @interface.solicit_feedback(row)
      end
    end
  end
end
