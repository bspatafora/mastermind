module Mastermind
  class Human
    def solicit_feedback
      print "Provide feedback on the last guess (2 = right number, right position; 1 = right number, wrong position; example input: 211): "
      check_feedback(gets.chomp)
    end

    private

    def check_feedback(feedback)
      pegs = feedback.split('').map { |x| x.to_i }
      valid_length = pegs.size <= 4
      valid_digits = pegs.all? { |clue| (1..2).include? clue }
      if valid_length && valid_digits
        return pegs
      else
        solicit_feedback
      end
    end
  end
end
