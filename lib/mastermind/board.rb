module Mastermind
  class Board
    attr_accessor :rows

    def initialize(rows = 10)
      @rows = Array.new(rows) { Row.new }
    end
  end
end
