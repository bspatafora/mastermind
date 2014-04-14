require 'spec_helper'

describe Mastermind::CodePegHole do

  before { @code_peg_hole = Mastermind::CodePegHole.new }

  it "is initialized with a nil peg" do
    expect(@code_peg_hole.peg).to eql(nil)
  end

  it "is initialized to accept code pegs (1..6) by default" do
    expect(@code_peg_hole.code_pegs).to eql((1..6))
  end

  it "can be initialized to accept more code pegs" do
    code_peg_hole = Mastermind::CodePegHole.new((1..10))
    expect(code_peg_hole.code_pegs).to eql((1..10))
  end

  it "can have its peg set to a valid code peg" do
    expect { @code_peg_hole.set_peg(1) }.not_to raise_error
  end

  it "can't have its peg set to an invalid code peg" do
    expect { @code_peg_hole.set_peg('a') }.to raise_error(ArgumentError)
  end

end
