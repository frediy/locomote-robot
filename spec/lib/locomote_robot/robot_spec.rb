require 'spec_helper'

RSpec.describe Robot do
  subject (:robot) { Robot.new }

  describe '#process_command' do
    let (:command) {}

    subject (:process_command!) { robot.process_command!(command) }
  end

  describe '#place' do
    let (:x) { 0 }
    let (:y) { 0 }
    let (:facing) { 'NORTH' }

    subject (:place) { robot.place(x, y, facing) }

    before do
      place
    end

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

        specify { expect(robot.x).to eq nil }
        specify { expect(robot.y).to eq nil }
        specify { expect(robot.facing).to eq nil }
      end

      context 'east' do
        let (:x) { 5 }
        let (:y) { 0 }

        specify { expect(robot.x).to eq nil }
        specify { expect(robot.y).to eq nil }
        specify { expect(robot.facing).to eq nil }
      end

      context 'south' do
        let (:x) { 0 }
        let (:y) { -1 }

        specify { expect(robot.x).to eq nil }
        specify { expect(robot.y).to eq nil }
        specify { expect(robot.facing).to eq nil }
      end

      context 'west' do
        let (:x) { -1 }
        let (:y) { 0 }

        specify { expect(robot.x).to eq nil }
        specify { expect(robot.y).to eq nil }
        specify { expect(robot.facing).to eq nil }
      end
    end

    context 'facing is valid' do
      context 'NORTH' do
        let(:facing) { 'NORTH' }

        specify { expect(robot.x).to eq x }
        specify { expect(robot.y).to eq y }
        specify { expect(robot.facing).to eq facing }
      end

      context 'EAST' do
        let(:facing) { 'EAST' }

        specify { expect(robot.x).to eq x }
        specify { expect(robot.y).to eq y }
        specify { expect(robot.facing).to eq facing }
      end

      context 'SOUTH' do
        let(:facing) { 'SOUTH' }

        specify { expect(robot.x).to eq x }
        specify { expect(robot.y).to eq y }
        specify { expect(robot.facing).to eq facing }
      end

      context 'WEST' do
        let(:facing) { 'WEST' }

        specify { expect(robot.x).to eq x }
        specify { expect(robot.y).to eq y }
        specify { expect(robot.facing).to eq facing }
      end
    end

    context 'facing is invalid' do
      let (:facing) { 'INVALID_FACING' }

      specify { expect(robot.x).to eq nil }
      specify { expect(robot.y).to eq nil }
      specify { expect(robot.facing).to eq nil }
    end
  end

  describe '#move' do
    let(:place) { robot.place(x, y, facing) }

    subject (:move) { robot.move }

    context 'placed' do
      before do
        place
      end

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
    subject (:left) { robot.left }

    # facing north
      # facing eastuu
    # facing east
      # facing north
    # facing south
      # facing east
    # facing west
      # facing south
  end

  describe '#right' do
    subject (:right) { robot.right }

    # facing north
      # facing east
    # facing east
      # facing south
    # facing south
      # facing west
    # facing west
      # facing north
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
