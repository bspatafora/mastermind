require 'spec_helper'

describe Mastermind::Computer do
  it "responds to solicit_guess with a shitty guess" do
    computer = Mastermind::Computer.new
    expect(computer.solicit_guess("board")).to eql([1, 1, 2, 2])
  end
end
