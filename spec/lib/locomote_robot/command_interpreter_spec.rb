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
    end

    describe 'LEFT' do
    end

    describe 'RIGHT' do
    end

    describe 'REPORT' do
    end
  end
end