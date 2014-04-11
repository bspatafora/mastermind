require_relative './mastermind/version.rb' # Change back to normal require?

module Mastermind
end

require_relative './mastermind/code_peg_hole.rb'
require_relative './mastermind/key_peg_hole.rb'
require_relative './mastermind/row.rb'
require_relative './mastermind/board.rb'
require_relative './mastermind/computer.rb'
require_relative './mastermind/game.rb'

# WHERE SHOULD THIS ACTUALLY GO?
game = Mastermind::Game.new
game.play
