module Mastermind
  class Computer
    def initialize(board)
      @board = board
      @row_size = 4
      @code_pegs = (1..6)
      @possible_codes = generate_all_codes
      @unguessed_codes = generate_all_codes
    end

    def solicit_guess
      if first_guess?
        [1, 1, 2, 2]
      else
        update_code_lists
        scored_guesses = generate_scored_guesses
        scored_guesses.each do |guess, score|
          return guess if score == scored_guesses.values.max && @possible_codes.include?(guess)
        end
        scored_guesses.each do |guess, score|
          return guess if score == scored_guesses.values.max
        end
      end
    end

    def update_code_lists
      @unguessed_codes.delete(retrieve_last_guess)
      @possible_codes = @possible_codes - generate_codes_to_eliminate(retrieve_last_guess, retrieve_last_feedback)
    end

    def generate_scored_guesses
      scored_guesses = Hash.new
      @unguessed_codes.each { |guess| scored_guesses.store(guess, score(guess)) }
      scored_guesses
    end

    def score(guess)
      eliminations_set = Array.new
      generate_all_feedbacks.each do |feedback|
        eliminations_set.push(generate_codes_to_eliminate(guess, feedback).count)
      end
      eliminations_set.min
    end

    def generate_codes_to_eliminate(guess, feedback)
      to_eliminate = Array.new
      feedback.sort!
      @possible_codes.each { |code| to_eliminate.push(code) if !solicit_feedback(code, guess).eql? feedback }
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
      guess.each_with_index { |peg, index| correct_position_set.push(1) if peg == code[index] }
      correct_position_set
    end

    def generate_correct_color_set(guess, code)
      correct_color_set = Array.new
      @code_pegs.each do |peg|
        if code.include? peg
          instances_in_code = code.count(peg)
          instances_in_guess = guess.count(peg)
          while instances_in_code > 0 && instances_in_guess > 0
            correct_color_set.push(2)
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
      feedbacks.push(empty_feedback)
      (1..@row_size).each do |length|
        [1, 2].repeated_combination(length).to_a.each { |feedback| feedbacks.push(feedback) }
      end
      feedbacks
    end

    def retrieve_last_guess
      retrieve_last_row.code_peg_holes
    end

    def retrieve_last_feedback
      retrieve_last_row.key_peg_holes
    end

    def retrieve_last_row
      @board.rows.reverse_each { |row| return row if !row_empty? row }
    end

    def first_guess?
      row_empty?(@board.rows.first)
    end

    def row_empty?(row)
      row.code_peg_holes.eql? Row.new.code_peg_holes
    end
  end
end
