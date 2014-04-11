require_relative './mastermind/version.rb'

module Mastermind
end

require_relative './mastermind/code_peg_hole.rb'
require_relative './mastermind/key_peg_hole.rb'
require_relative './mastermind/row.rb'
require_relative './mastermind/board.rb'
require_relative './mastermind/computer.rb'
require_relative './mastermind/human.rb'
require_relative './mastermind/game.rb'

if __FILE__ == $0
  game = Mastermind::Game.new
  game.play
end
