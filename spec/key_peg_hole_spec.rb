require 'spec_helper'

module Mastermind
  describe KeyPegHole do

    before { @key_peg_hole = KeyPegHole.new }

    it "is initialized with a nil peg" do
      expect(@key_peg_hole.peg).to equal(nil)
    end

    it "can have its peg set to a valid key peg" do
      expect { @key_peg_hole.set_peg(1) }.not_to raise_error
    end

    it "can't have its peg set to an invalid key peg" do
      expect { @key_peg_hole.set_peg('a') }.to raise_error(ArgumentError)
    end

  end
end
