require_relative './mastermind/version.rb' # Change back to normal require?

module Mastermind
end

require_relative './mastermind/code_peg_hole.rb'
require_relative './mastermind/key_peg_hole.rb'
require_relative './mastermind/row.rb'
require_relative './mastermind/board.rb'

# WHERE SHOULD THIS ACTUALLY GO?
board = Mastermind::Board.new
board.draw
