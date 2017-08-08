require "spec_helper"

module LocomoteRobot
  RSpec.describe Robot do
    subject(:robot) { Robot.new }

    describe '#process_command' do
      let(:command) {}

      subject(:process_command!) { robot.process_command!(command) }
    end

    describe '#place' do
      let(:x) {}
      let(:y) {}
      let(:facing) {}

      subject(:place) { robot.place(x, y, facing) }

      # place on board
        # x is x
        # y is y
      # place off board
        # x is nil
        # y is nil
      # facing is valid
        # NORTH
        # EAST
        # SOUTH
        # WEST
      # facing is invalid
        # x is nil
        # y is nil
        # facing is nil
    end

    describe '#move' do
      subject(:move) { robot.move }

      # placed
        # facing north
          # one step forward is on the board
            # y += 1
            # x does not change
          # one step forward is not on the board
        # facing east
          # one step forward is on the board
            # y does not change
            # x += 1
          # one step forward is not on the board
            # x,y does not change
        # facing south
          # one step forward is on the board
            # y -= 1
            # x does not change
          # one step forward is not on the board
            # x,y does not change
        # facing west
          # one step forward is on the board
            # y does not change
            # x -= 1
          # one step forward is not on the board
            # x,y does not change
      # unplaced
        # x and y is nil
    end

    describe '#left' do
      subject (:left) { robot.left }

      # facing north
        # facing east
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
      subject(:output?) { robot.output? }
    end

    describe '#output' do
      # set output to position

      subject(:output) { robot.output }

      # last command was report
      # last command was not report
    end

    describe '#clean_output' do
      # set output to position

      subject(:clean_output!) { robot.clean_output! }
    end
  end
end
