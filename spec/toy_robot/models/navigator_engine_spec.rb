# frozen_string_literal: true

describe ToyRobot::NavigatorEngine do
  let(:table) do
    double('Table', x_range: 2, y_range: 2, holes: [{x:1, y:2}])
  end

  subject(:navigator_engine) { described_class.new(table) }

  describe '#valid_position?' do
    context 'when table does not support desirable positions' do
      subject(:valid_position?) { navigator_engine.valid_position?(3, 3) }

      it { is_expected.to be_falsey }
    end

    context 'when desirable positions are on the table' do
      subject(:valid_position?) { navigator_engine.valid_position?(2, 2) }

      it { is_expected.to be_truthy }
    end

    context 'when there is a hole' do
      subject(:valid_position?) { navigator_engine.valid_position?(2, 2) }

      it { is_expected.to be_falsey }
    end
  end

  describe '#viable_route?' do
    let(:table) { ToyRobot::Table.new(x_range:4, y_range:4) }

    before do
      table.add_holes(
        [
          {x: 2, y: 1 },
          {x:2, y:2 },
          {x:2, y:3 },
          {x:3, y: 2 }
        ]
      )
    end

    it 'returns true if there is a viable route' do
      expect(navigator_engine.viable_route?(3, 2)).to be_falsey
    end
  end

  describe '#on_table?' do
    subject(:on_table?) { navigator_engine.on_table? }

    context 'when robot positions are empty' do
      before do
        navigator_engine.update(nil, nil)
      end

      it { is_expected.to be_falsey }
    end

    context 'when robot positions were updated' do
      before do
        navigator_engine.update(3, 0)
      end

      it { is_expected.to be_truthy }
    end
  end
end
