require 'spec_helper'

module Mastermind
  describe 'Row' do

    it "should consist of 4 CodePegHoles and 4 KeyPegHoles" do
      row = Row.new
      expect(row.get_guess).to have(4).things
      expect(row.get_clues).to have(4).things
    end
  end
end
