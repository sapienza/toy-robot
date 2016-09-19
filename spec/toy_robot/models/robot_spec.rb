# frozen_string_literal: true

describe ToyRobot::Robot do
  RSpec.shared_examples 'a turning' do
    it 'turns the robot' do
      robot.place(x: 0, y: 1, facing: :north)

      expect { robot.right }.to change(robot, :facing)
    end
  end

  RSpec.shared_examples 'a non-turning robot' do
    it 'it does not turn' do
      expect { robot.right }.to_not change(robot, :facing)
    end
  end

  RSpec.shared_examples 'a non-moving robot' do
    it 'does not move in x' do
      expect { robot.move }.to_not change(robot, :x_position)
    end

    it 'does not move in y' do
      expect { robot.move }.to_not change(robot, :y_position)
    end
  end

  let(:compass_engine) { ToyRobot::CompassEngine.instance }
  let(:destruction_risk) { false }
  let(:on_table) { true }
  let(:valid_position) { true }

  let(:navigator_engine) do
    double(
      'NavigatorEngine',
      valid_position?: valid_position,
      add_observer: true,
      on_table?: on_table,
      destruction_risk?: destruction_risk,
      update: true
    )
  end

  let(:robot) { described_class.new(compass_engine, navigator_engine) }

  describe '#place' do
    before { robot.place(x: 2, y: 3, facing: :south) }

    it 'changes robot x position' do
      expect(robot.x_position).to eq(2)
    end

    it 'changes robot y position' do
      expect(robot.y_position).to eq(3)
    end

    it 'changes robot facing' do
      expect(robot.facing).to eq(:south)
    end

    context 'when position is invalid' do
      let(:valid_position) { false }

      it 'does not changes robot x position' do
        expect(robot.x_position).to eq(nil)
      end

      it 'does not changes y position' do
        expect(robot.y_position).to eq(nil)
      end

      it 'does not changes robot facing' do
        expect(robot.facing).to eq(nil)
      end
    end
  end

  describe '#move' do
    context 'when robot is facing a horizontal axis' do
      it 'moves one unit from in x axis' do
        robot.place(x: 1, y: 0, facing: :east)

        expect { robot.move }.to change(robot, :x_position).by(1)
      end
    end

    context 'when robot is facing a vertical axis' do
      it 'moves one unit from in y axis' do
        robot.place(x: 0, y: 1, facing: :north)

        expect { robot.move }.to change(robot, :y_position).by(1)
      end
    end

    context 'when robot is not on table' do
      let(:on_table) { false }

      before { robot.place(x: 1, y: 0, facing: :east) }

      it_behaves_like 'a non-moving robot'
    end

    context 'when the move leads to extermination' do
      let(:on_table) { true }

      before do
        allow(navigator_engine)
          .to receive(:valid_position?)
          .and_return(true, false)

        robot.place(x: 1, y: 0, facing: :east)
      end

      it_behaves_like 'a non-moving robot'
    end
  end

  describe '#left' do
    it_behaves_like 'a turning'

    context 'when robot is not on table' do
      let(:on_table) { false }

      it_behaves_like 'a non-turning robot'
    end
  end

  describe '#right' do
    it_behaves_like 'a turning'

    context 'when robot is not on table' do
      let(:on_table) { false }

      it_behaves_like 'a non-turning robot'
    end
  end

  describe '#report' do
    it 'reports x, y and facing' do
      robot.place(x: 2, y: 3, facing: :east)

      expect(STDOUT).to receive(:puts).with('2,3,east')

      robot.report
    end

    context 'when robot is not on table' do
      let(:on_table) { false }

      it 'does not report' do
        expect(robot.report).to eq(nil)
      end
    end
  end
end
