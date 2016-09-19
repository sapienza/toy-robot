# frozen_string_literal: true

describe ToyRobot::CommandCenter do
  let(:table) { double('Table') }

  subject(:command_center) { described_class.new(commands, table) }

  describe '#execute' do
    context 'when the command has no options' do
      let(:commands) do
        [
          { command: :move, options: nil, subject: :robot }
        ]
      end

      it 'calls the method' do
        expect_any_instance_of(ToyRobot::Robot)
          .to receive(:move)
          .with(no_args)

        command_center.execute
      end
    end

    context 'when the command has options' do
      let(:options) { { x: 0, y: 5, facing: :north } }

      let(:commands) do
        [{ command: :place, options: options, subject: :robot }]
      end

      it 'calls the method passing the options hash' do
        expect_any_instance_of(ToyRobot::Robot)
          .to receive(:place)
          .with(x: 0, y: 5, facing: :north)

        command_center.execute
      end
    end
  end
end
