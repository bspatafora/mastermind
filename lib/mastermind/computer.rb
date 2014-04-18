module Mastermind
  class Computer
    def initialize
      @row_size = 4
      @code_pegs = (1..6)
      @all_codes = generate_all_codes
      @possible_codes = generate_all_codes
      @unguessed_codes = generate_all_codes
      @all_feedbacks = generate_all_feedbacks
    end

    def solicit_guess(board)
      if first_guess?(board)
        [1, 1, 2, 2]
      else
        determine_row_of_last_guess(board)
        @unguessed_codes.delete(@last_guess)
        to_eliminate = generate_codes_to_eliminate(@last_guess, @last_guess_feedback)
        @possible_codes = @possible_codes - to_eliminate
        scored_guesses = Hash.new
        @unguessed_codes.each do |guess|
          scored_guesses.store(guess, score_guess(guess))
        end
        candidates = Array.new
        scored_guesses.each do |guess, score|
          candidates.push(guess) if score == scored_guesses.values.max
        end
        candidates_in_possible_codes = Array.new
        candidates.each do |guess|
          candidates_in_possible_codes.push(guess) if @possible_codes.include? guess
        end
        if !candidates_in_possible_codes.empty?
          candidates_in_possible_codes.first
        else
          candidates.first
        end
      end
    end

    def score_guess(guess)
      possibility_eliminations = Array.new
      @all_feedbacks.each do |feedback|
        possibility_eliminations.push(generate_codes_to_eliminate(guess, feedback).count)
      end
      possibility_eliminations.min
    end

    def solicit_feedback(guess, code)
      feedback = Array.new
      correct_position = Array.new 
      correct_color = Array.new
      guess.each_with_index { |peg, index| correct_position.push(1) if peg == code[index] }
      @code_pegs.each do |peg|
        if code.include? peg
          instances_in_code = code.count(peg)
          instances_in_guess = guess.count(peg)
          while instances_in_code > 0 && instances_in_guess > 0
            correct_color.push(2)
            instances_in_code -= 1
            instances_in_guess -= 1
          end
        end
      end
      correct_color.pop(correct_position.count)
      correct_position.each { |peg| feedback.push(peg) }
      correct_color.each { |peg| feedback.push(peg) }
      feedback
    end

    def generate_codes_to_eliminate(guess, feedback)
      to_eliminate = Array.new
      feedback.compact!
      feedback.sort!
      @possible_codes.each do |code|
        if solicit_feedback(code, guess) != feedback
          to_eliminate.push(code)
        end
      end
      to_eliminate
    end

    def generate_all_codes
      @code_pegs.to_a.repeated_permutation(@row_size).to_a
    end

    def generate_all_feedbacks
      feedbacks = Array.new
      (1..@row_size).each do |length|
        [1, 2].repeated_combination(length).to_a.each { |feedback| feedbacks.push(feedback) }
      end
      feedbacks
    end

    def determine_row_of_last_guess(board)
      board.rows.each do |row|
        if !row_empty?(row)
          @last_guess = row.code_peg_holes
          @last_guess_feedback = row.key_peg_holes
        end
      end
      # TEMPORARY RETURN FOR TESTING
      @last_guess
    end

    def row_empty?(row)
      row.code_peg_holes.eql? Row.new.code_peg_holes
    end

    def first_guess?(board)
      row_empty?(board.rows.first)
    end
  end
end
