# frozen_string_literal: true

describe ToyRobot::CLI do
  describe '#execute' do
    subject(:cli) { described_class.new }
    subject(:execute) { cli.execute }

    before do
      allow_any_instance_of(ToyRobot::Parser).to receive(:parse)
      allow_any_instance_of(ToyRobot::CommandCenter).to receive(:execute)
    end

    it { is_expected.to be_truthy }
  end
end
