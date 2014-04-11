require 'spec_helper'

module Mastermind
  describe Computer do
    it "responds to solicit_guess with a shitty guess" do
      computer = Computer.new
      expect(computer.solicit_guess("board")).to eql([1, 2, 3, 4])
    end
  end
end
