# frozen_string_literal: true
describe ToyRobot::CLI do
  describe '#hello_world' do
    # let(:options) { { instructions_file: '' } }
    subject(:cli) { described_class.new }
    subject(:execute) { cli.execute }

    it { is_expected.to eq('Hello World!') }
  end
end
