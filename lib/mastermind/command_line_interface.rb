module Mastermind
  class CommandLineInterface
    def initialize(board)
      @board = board
    end

    def say_game_over(winner)
      puts stringify_game_over(winner)
    end

    def solicit_code
      begin
        print stringify_solicit_code_message
        send_code(gets.chomp)
      rescue InvalidCode
        print stringify_error_message
        solicit_code
      end
    end

    def send_code(input)
      code = input.split('').map { |digit| digit.to_i }
      @board.set_code(code)
    end

    def solicit_feedback(row)
      begin
        print stringify_solicit_feedback_message
        send_feedback(gets.chomp, row)
      rescue TooManyPegs, InvalidPegs
        print stringify_error_message
        solicit_feedback(row)
      end
    end

    def send_feedback(input, row)
      feedback = input.split('').map { |digit| digit.to_i }
      row.set_key_peg_holes(feedback)
    end

    def draw_board
      print stringify_board
    end

    def stringify_board
      <<eos

#{stringify_code_pegs(@board.code)}
#{stringify_horizontal_divider(24)}
#{stringify_rows}
eos
    end

    private

    def stringify_game_over(winner)
      "#{winner} wins!"
    end

    def stringify_rows
      rows = String.new
      @board.rows.each do |row|
        rows.concat(stringify_code_pegs(row.code_peg_holes))
        rows.concat(stringify_vertical_divider)
        rows.concat(stringify_key_pegs(row.key_peg_holes))
        rows.concat("\n")
      end
      rows
    end

    def stringify_code_pegs(pegs)
      pegs.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
    end

    def stringify_key_pegs(pegs)
      pegs.join
    end

    def stringify_horizontal_divider(width)
      "_" * width
    end

    def stringify_vertical_divider
      " | "
    end

    def stringify_computer_victory_message
      <<eos
Computer wins!
eos
    end

    def stringify_human_victory_message
      <<eos
You win!
eos
    end

    def stringify_solicit_code_message
      <<eos
Pick a #{@board.row_size}-digit code
  Digits may be between #{@board.code_pegs.first} and #{@board.code_pegs.last}
eos
    end

    def stringify_solicit_feedback_message
      <<eos
Provide feedback on the last guess
  1 = correct number, correct position
  2 = correct number, incorrect position
  Example input: 122
eos
    end

    def stringify_error_message
      <<eos

Invalid Entry

eos
    end
  end
end
