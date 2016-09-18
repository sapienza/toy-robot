# frozen_string_literal: true

describe ToyRobot::Parser do
  RSpec.shared_examples 'a robot command without options' do
    it do
      is_expected.to include(
        command: instructions.first, options: nil, subject: 'robot'
      )
    end
  end

  describe '#parse' do
    subject(:parse) { described_class.new('file_path').parse }

    let(:instructions) { ['place 4,2,east'] }

    before do
      allow_any_instance_of(ToyRobot::Adapters::InstructionsFromTxt)
        .to receive(:execute)
        .and_return(instructions)
    end

    context 'when is a place command' do
      it do
        is_expected.to include(
          command: 'place',
          options: { 'x' => '4', 'y' => '2', 'facing' => 'east' },
          subject: 'robot'
        )
      end
    end

    context 'when is a move command' do
      let(:instructions) { ['move'] }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a left command' do
      let(:instructions) { ['left'] }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a right command' do
      let(:instructions) { ['right'] }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a report command' do
      let(:instructions) { ['report'] }

      it_behaves_like 'a robot command without options'
    end

    context 'when command is not valid' do
      let(:instructions) { ['explode'] }

      it 'raises InvalidCommandError' do
        expect do
          parse
        end.to raise_error(
          ToyRobot::InvalidCommandError, 'Invalid command: explode'
        )
      end
    end

    context 'when command does not support options' do
      let(:instructions) { ['move 2'] }

      it 'raises InvalidCommandError' do
        expect do
          parse
        end.to raise_error(
          ToyRobot::InvalidCommandError, 'move does not support options!'
        )
      end
    end
  end
end
