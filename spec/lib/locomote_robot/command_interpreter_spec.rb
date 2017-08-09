require 'spec_helper'

RSpec.describe CommandInterpreter do
  let(:robot) { instance_double(Robot) }

  subject (:command_interpreter) { CommandInterpreter.new(robot) }

  describe '#process_command' do
    subject (:process_command) { command_interpreter.process_command(command) }

    describe 'PLACE X,Y,FACING' do
      let (:command) { 'PLACE 0,0,NORTH' }

      specify do
        expect(robot).to receive(:place).with(0, 0, Robot::NORTH)
        process_command
      end
    end

    describe 'MOVE' do
      let (:command) { 'MOVE' }
      specify { expect(robot).to receive(:move); process_command }
    end

    describe 'LEFT' do
      let (:command) { 'LEFT' }
      specify { expect(robot).to receive(:left); process_command }
    end

    describe 'RIGHT' do
      let (:command) { 'RIGHT' }
      specify { expect(robot).to receive(:right); process_command }
    end

    describe 'REPORT' do
    end
  end
end