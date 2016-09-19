# frozen_string_literal: true

describe ToyRobot::Adapters::InstructionsFromTxt do
  describe '#execute' do
    let(:file_path) { './spec/support/commands.txt' }

    subject(:execute) { described_class.new(file_path).execute }

    it 'returns an array with instructions' do
      expect(execute).to eq(['place 4,2,east', 'move', 'report'])
    end
  end
end
