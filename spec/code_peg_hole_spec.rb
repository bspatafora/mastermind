require 'spec_helper'

module Mastermind
  describe 'CodePegHole' do

    context '#initialize' do
      it 'is initialized with a nil peg by default' do
        code_peg_hole = CodePegHole.new
        expect(code_peg_hole.peg).to equal(nil)
      end

      it 'can be initialized with an integer peg' do
        code_peg_hole = CodePegHole.new(0)
        expect(code_peg_hole.peg).to equal(0)
      end
    end

  end
end
