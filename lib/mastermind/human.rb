module Mastermind
  class Human
    def solicit_feedback(row)
      print "Provide feedback on the last guess (1 = right number, right position; 2 = right number, wrong position; example input: 122): "
      check_feedback(row, gets.chomp)
    end

    private

    def check_feedback(row, feedback)
      begin
        pegs = feedback.split('').map { |x| x.to_i }
        row.set_key_peg_holes(pegs)
      rescue TooManyPegs, InvalidPegs => error
        puts error.message
        solicit_feedback(row)
      end
    end
  end
end
