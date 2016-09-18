# frozen_string_literal: true

describe ToyRobot::CompassEngine do
  subject(:compass) { described_class.instance }

  describe '#walking_directions' do
    it 'returns the walking directions when facing north' do
      expect(compass.walking_directions(:north)).to eq(y: :+)
    end

    it 'returns the walking directions when facing east' do
      expect(compass.walking_directions(:east)).to eq(x: :+)
    end

    it 'returns the walking directions when facing east' do
      expect(compass.walking_directions(:south)).to eq(y: :-)
    end

    it 'returns the walking directions when facing east' do
      expect(compass.walking_directions(:west)).to eq(x: :-)
    end
  end

  describe '#right_cardinal_name' do
    it 'returns east when facing north' do
      expect(subject.right_cardinal_name(:north)).to eq(:east)
    end

    it 'returns south when facing east' do
      expect(subject.right_cardinal_name(:east)).to eq(:south)
    end

    it 'returns west when facing south' do
      expect(subject.right_cardinal_name(:south)).to eq(:west)
    end

    it 'returns north when facing west' do
      expect(subject.right_cardinal_name(:west)).to eq(:north)
    end
  end

  describe '#left_cardinal_name' do
    it 'returns south when facing west' do
      expect(subject.left_cardinal_name(:west)).to eq(:south)
    end

    it 'returns east when facing south' do
      expect(subject.left_cardinal_name(:south)).to eq(:east)
    end

    it 'returns north when facing east' do
      expect(subject.left_cardinal_name(:east)).to eq(:north)
    end

    it 'returns west when facing north' do
      expect(subject.left_cardinal_name(:north)).to eq(:west)
    end
  end
end
