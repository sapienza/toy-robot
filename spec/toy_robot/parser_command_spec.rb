# frozen_string_literal: true

describe ToyRobot::ParserCommand do
  RSpec.shared_examples 'a robot command without options' do
    it do
      is_expected.to include(
        command: instruction.to_sym, options: nil, subject: :robot
      )
    end
  end

  describe '#normalize' do
    let(:instruction) { 'place 4,2,east' }

    subject(:normalize) { described_class.new(instruction).normalize }

    context 'when is a place command' do
      it do
        is_expected.to include(
          command: :place,
          options: { x: '4', y: '2', facing: 'east' },
          subject: :robot
        )
      end
    end

    context 'when is a move command' do
      let(:instruction) { 'move' }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a left command' do
      let(:instruction) { 'left' }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a right command' do
      let(:instruction) { 'right' }

      it_behaves_like 'a robot command without options'
    end

    context 'when is a report command' do
      let(:instruction) { 'report' }

      it_behaves_like 'a robot command without options'
    end

    context 'when command is not valid' do
      let(:instruction) { 'explode' }

      it 'raises InvalidCommandError' do
        expect do
          normalize
        end.to raise_error(
          ToyRobot::ParserCommand::InvalidCommandError,
          'Invalid command: explode'
        )
      end
    end

    context 'when command does not support options' do
      let(:instruction) { 'move 2' }

      it 'raises InvalidCommandError' do
        expect do
          normalize
        end.to raise_error(
          ToyRobot::ParserCommand::InvalidCommandError,
          'move does not support options!'
        )
      end
    end
  end
end
