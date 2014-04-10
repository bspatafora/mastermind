module Mastermind
  class Board
    attr_accessor :rows

    def initialize(rows = 10)
      @rows = Array.new(rows) { Row.new }
    end

    def draw
      24.times { print "_" }
      puts
      @rows.each do |row|
        print row.get_guess.map { |peg| peg.nil? ? "[ ]" : "[#{peg}]" }.join(" ")
        print "  |  "
        print row.get_clues.join
        puts
      end
    end
  end
end
