# frozen_string_literal: true
describe ToyRobot::CLI do
  describe '#hello_world' do
    it 'returns a Hello World!' do
      expect(described_class.hello_world).to eq('Hello World!')
    end
  end
end
