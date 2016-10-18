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

  describe '#add_holes' do
    let(:table) { described_class.new(x_range: 5, y_range: 5) }

    it 'adds holes on the table' do
      table.add_holes([{x: 2, y: 1}, {x:1, y: 2}])

      expect(table.holes).to match_array(
        [{x: 2, y: 1}, {x:1, y: 2}]
      )
    end
  end
end
