# frozen_string_literal: true

describe ToyRobot::Parser do
  describe '#parse' do
    subject(:parse) { described_class.new('file_path').parse }
    let(:instructions) { ['place 4,2,east', 'move'] }

    before do
      allow_any_instance_of(ToyRobot::Adapters::InstructionsFromTxt)
        .to receive(:execute)
        .and_return(instructions)
    end

    it { is_expected.to all(be_an(Hash)) }

    it 'builds all the instructions' do
      expect(parse.size).to eq(2)
    end
  end
end
