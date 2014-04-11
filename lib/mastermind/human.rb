module Mastermind
  class Human
    def solicit_clues
      print "Provide feedback on the last guess (2 = right number, right position; 1 = right number, wrong position; example input: 211): "
      check_clues(gets.chomp)
    end

    private

    def check_clues(input)
      clues = input.split('').map { |x| x.to_i }
      valid_length = clues.size <= 4
      valid_digits = clues.all? { |clue| (1..2).include? clue }
      if valid_length && valid_digits
        return clues
      else
        solicit_clues
      end
    end
  end
end
