require 'spec_helper'

module Mastermind
  describe 'CodePegHole' do

    before { @code_peg_hole = CodePegHole.new }

    it "is initialized with a nil peg" do
      expect(@code_peg_hole.peg).to equal(nil)
    end

    it "can have its peg set to a valid code peg" do
      expect { @code_peg_hole.set_peg(1) }.not_to raise_error
    end

    it "can't have its peg set to an invalid code peg" do
      expect { @code_peg_hole.set_peg('a') }.to raise_error(ArgumentError)
    end

  end
end
