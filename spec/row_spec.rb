require 'spec_helper'

describe Mastermind::Row do

  before {  @row = Mastermind::Row.new() }

  it "is initialized with 4 code peg holes by default" do
    expect(@row.get_code_peg_holes).to have(4).things
  end

  it "is initialized with 4 key peg holes by default" do
    expect(@row.get_key_peg_holes).to have(4).things
  end

  it "can be initialized with more code peg holes" do
    row = Mastermind::Row.new(5)
    expect(row.get_code_peg_holes).to have(5).things
  end

  it "can be initialized with more key peg holes" do
    row = Mastermind::Row.new(5)
    expect(row.get_key_peg_holes).to have(5).things
  end

  it "can have its code peg holes set" do
    @row.set_code_peg_holes([1, 1, 1, 1])
    expect(@row.get_code_peg_holes).to eql([1, 1, 1, 1])
  end

  it "can have its key peg holes set" do
    @row.set_key_peg_holes([1, 1])
    expect(@row.get_key_peg_holes).to eql([1, 1, nil, nil])
  end

  it "can't have fewer code peg holes set than the number initialized with" do
    row = Mastermind::Row.new(2)
    expect { @row.set_code_peg_holes([1]) }.to raise_error(ArgumentError)
  end

  it "can't have more code peg holes set than the number initialized with" do
    row = Mastermind::Row.new(2)
    expect { @row.set_code_peg_holes([1, 1, 1]) }.to raise_error(ArgumentError)
  end

  it "can't have more key peg holes set than the number initialized with" do
    row = Mastermind::Row.new(2)
    expect { row.set_key_peg_holes([1, 1, 1]) }.to raise_error(ArgumentError)
  end
end
