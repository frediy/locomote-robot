require 'spec_helper'

RSpec.describe Robot do
  subject (:robot) { Robot.new }

  describe '#process_command' do
    let (:command) {}

    subject (:process_command!) { robot.process_command!(command) }
  end

  describe '#placed?' do
    let (:place) { robot.place(x, y, facing) }

    subject (:placed?) { robot.placed? }

    let (:x) { 0 }
    let (:y) { 0 }
    let (:facing) { Robot::NORTH }

    context 'placed at valid position with valid facing' do
      specify { expect{place}.to change{robot.placed?}.from(false).to(true) }
    end

    context 'y coordinate not valid' do
      let (:y) { 8 }
      it { is_expected.to be false }
    end

    context 'x coordinate not valid' do
      let (:x) { 8 }
      it { is_expected.to be false }
    end

    context 'facing not valid' do
      let (:facing) { 'INVALID_FACING'}
      it { is_expected.to be false }
    end
  end

  describe '#place' do
    let (:x) { 0 }
    let (:y) { 0 }
    let (:facing) { Robot::NORTH }

    subject (:place) { robot.place(x, y, facing) }

    before { place }

    context 'place on board' do
      let (:x) { 0 }
      let (:y) { 0 }

      specify { expect(robot.x).to eq x }
      specify { expect(robot.y).to eq y }
      specify { expect(robot.facing).to eq facing }
    end

    context 'place off board' do
      context 'north' do
        let (:x) { 0 }
        let (:y) { 5 }

        specify { expect(robot.placed?).to be false }
      end

      context 'east' do
        let (:x) { 5 }
        let (:y) { 0 }

        specify { expect(robot.placed?).to be false }
      end

      context 'south' do
        let (:x) { 0 }
        let (:y) { -1 }

        specify { expect(robot.placed?).to be false }
      end

      context 'west' do
        let (:x) { -1 }
        let (:y) { 0 }

        specify { expect(robot.placed?).to be false }
      end
    end

    shared_examples_for 'a successful #place' do
      specify { expect(robot.x).to eq x }
      specify { expect(robot.y).to eq y }
      specify { expect(robot.facing).to eq facing }
    end

    context 'facing is valid' do
      context 'NORTH' do
        let(:facing) { Robot::NORTH }

        it_behaves_like 'a successful #place'
      end

      context 'EAST' do
        let(:facing) { Robot::EAST }

        it_behaves_like 'a successful #place'
      end

      context 'SOUTH' do
        let(:facing) { Robot::SOUTH }

        it_behaves_like 'a successful #place'
      end

      context 'WEST' do
        let(:facing) { Robot::WEST }

        it_behaves_like 'a successful #place'
      end
    end

    context 'facing is invalid' do
      let (:facing) { 'INVALID_FACING' }

      specify { expect(robot.placed?).to be false }
    end
  end

  describe '#move' do
    let(:place) { robot.place(x, y, facing) }

    subject (:move) { robot.move }

    context 'placed' do
      before { place }

      context 'facing north' do
        let (:x) { 0 }
        let (:facing) { 'NORTH' }

        context 'one step forward is on the board' do
          let (:y) { 3 }

          specify { expect{move}.to_not change{x} }
          specify { expect{move}.to change{robot.y}.to(4) }
        end

        context 'one step forward is not on the board' do
          let (:y) { 4 }

          specify { expect{move}.to_not change{x} }
          specify { expect{move}.to_not change{y} }
        end
      end

      context 'facing east' do
        let(:y) { 0 }
        let (:facing) { 'EAST' }

        context 'one step forward is on the board' do
          let (:x) { 3 }

          specify { expect{move}.to change{robot.x}.to(4) }
          specify { expect{move}.to_not change{y} }
        end

        context 'one step forward is not on the board' do
          let (:x) { 4 }

          specify { expect{move}.to_not change{x} }
          specify { expect{move}.to_not change{y} }
        end
      end

      context 'facing south' do
        let (:x) { 0 }
        let (:facing) { 'SOUTH' }

        context 'one step forward is on the board' do
          let (:y) { 1 }

          specify { expect{move}.to change{robot.y}.to(0) }
          specify { expect{move}.to_not change{x} }
        end

        context 'one step forward is not on the board' do
          let (:y) { 0 }

          specify { expect{move}.to_not change{x} }
          specify { expect{move}.to_not change{y} }
        end
      end

      context 'facing west' do
        let(:y) { 0 }
        let (:facing) { 'WEST' }

        context 'one step forward is on the board' do
          let (:x) { 1 }

          specify { expect{move}.to change{robot.x}.to(0) }
          specify { expect{move}.to_not change{y} }
        end

        context 'one step forward is not on the board' do
          let (:x) { 0 }

          specify { expect{move}.to_not change{x} }
          specify { expect{move}.to_not change{y} }
        end
      end
    end

    context 'unplaced' do
      specify { expect(robot.x).to eq nil }
      specify { expect(robot.y).to eq nil }
      specify { expect(robot.facing).to eq nil }
    end
  end

  describe '#left' do
    let(:x) { 0 }
    let(:y) { 0 }
    let(:facing) { Robot::NORTH }

    let(:place) { robot.place(x, y, facing) }

    subject (:left) { robot.left }

    context 'placed' do
      before { place }

      context 'facing north' do
        let (:facing) { Robot::NORTH }

        specify { expect{left}.to change{robot.facing}.to Robot::WEST }
      end

      context 'facing east' do
        let (:facing) { Robot::EAST }

        specify { expect{left}.to change{robot.facing}.to Robot::NORTH }
      end

      context 'facing south' do
        let (:facing) { Robot::SOUTH }

        specify { expect{left}.to change{robot.facing}.to Robot::EAST }
      end

      context 'facing west' do
        let (:facing) { Robot::WEST }

        specify { expect{left}.to change{robot.facing}.to Robot::SOUTH }
      end
    end

    context 'unplaced' do
      specify { expect{left}.to_not change{robot.facing} }
    end
  end

  describe '#right' do
    let(:x) { 0 }
    let(:y) { 0 }
    let(:facing) { Robot::NORTH }

    let(:place) { robot.place(x, y, facing) }

    subject (:right) { robot.right }

    context 'placed' do
      before { place }

      context 'facing north' do
        let (:facing) { Robot::NORTH }

        specify { expect{right}.to change{robot.facing}.to Robot::EAST }
      end

      context 'facing east' do
        let (:facing) { Robot::EAST }

        specify { expect{right}.to change{robot.facing}.to Robot::SOUTH }
      end

      context 'facing south'do
        let (:facing) { Robot::SOUTH }

        specify { expect{right}.to change{robot.facing}.to Robot::WEST }
      end

      context 'facing west' do
        let (:facing) { Robot::WEST }

        specify { expect{right}.to change{robot.facing}.to Robot::NORTH }
      end

    end

    context 'unplaced' do
      specify { expect{right}.to_not change{robot.facing} }
    end
  end

  describe '#output?' do
    subject (:output?) { robot.output? }
  end

  describe '#output' do
    # set output to position

    subject (:output) { robot.output }

    # last command was report
    # last command was not report
  end

  describe '#clean_output' do
    # set output to position

    subject (:clean_output!) { robot.clean_output! }
  end
end
