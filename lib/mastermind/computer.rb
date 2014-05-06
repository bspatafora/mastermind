module Mastermind
  class Computer
    def initialize(board)
      @board = board
      @row_size = 4
      @code_pegs = (1..6)
      @all_codes = generate_all_codes
    end

    def solicit_guess
      if first_guess?
        # Most informative first guesses are of the pattern xxyy.
        [1, 1, 2, 2]
      else
        get_possible_codes.first || ["L", "I", "A", "R"] # If scored_guesses is empty, the human has lied
      end
    end

    private

    def get_possible_codes
      possible_codes = generate_all_codes
      @board.rows.each do |row|
        unless row_empty?(row)
          codes_to_eliminate = generate_codes_to_eliminate(row.code_peg_holes, row.key_peg_holes) 
          possible_codes = possible_codes - codes_to_eliminate
        end
      end
      possible_codes
    end

    def generate_codes_to_eliminate(guess, feedback)
      to_eliminate = Array.new
      feedback.sort!
      @all_codes.each { |code| to_eliminate << code if !solicit_feedback(code, guess).eql? feedback }
      to_eliminate
    end

    def solicit_feedback(guess, code)
      correct_position_set = generate_correct_position_set(guess, code)
      correct_color_set = generate_correct_color_set(guess, code)
      correct_color_set.pop(correct_position_set.count)
      correct_position_set + correct_color_set
    end

    def generate_correct_position_set(guess, code)
      correct_position_set = Array.new
      guess.each_with_index { |peg, index| correct_position_set << 1 if peg == code[index] }
      correct_position_set
    end

    def generate_correct_color_set(guess, code)
      correct_color_set = Array.new
      @code_pegs.each do |peg|
        if code.include? peg
          instances_in_code = code.count(peg)
          instances_in_guess = guess.count(peg)
          while instances_in_code > 0 && instances_in_guess > 0
            correct_color_set << 2
            instances_in_code -= 1
            instances_in_guess -= 1
          end
        end
      end
      correct_color_set
    end

    def generate_all_codes
      @code_pegs.to_a.repeated_permutation(@row_size).to_a
    end

    def generate_all_feedbacks
      feedbacks = Array.new
      empty_feedback = []
      feedbacks << empty_feedback
      (1..@row_size).each do |length|
        [1, 2].repeated_combination(length).to_a.each { |feedback| feedbacks << feedback }
      end
      feedbacks
    end

    def first_guess?
      row_empty?(@board.rows.first)
    end

    def row_empty?(row)
      row.code_peg_holes.eql? Row.new.code_peg_holes
    end
  end
end
