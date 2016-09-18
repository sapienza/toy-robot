# frozen_string_literal: true
describe ToyRobot::Table do
  describe '#initialize' do
    it 'validates table size' do
      expect do
        described_class.new(x_range: 0, y_range: 0)
      end.to raise_error(
        ToyRobot::InvalidTableSize, 'Table sizes have to be bigger than 0'
      )
    end
  end
end
