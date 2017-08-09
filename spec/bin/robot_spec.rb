require 'spec_helper'

RSpec.describe 'bin/robot' do
  let(:command_file_path) { './tmp/test' }

  subject (:cli_call) { `./bin/robot #{command_file_path}` }

  before(:all) do
    # Ensure tmp directory exists
    unless File.directory?(LocomoteRobot.tmp_directory)
      FileUtils.mkdir_p(LocomoteRobot.tmp_directory)
    end
  end

  before do
    File.write(command_file_path, command_file_content)
  end

  describe 'problem examples' do
    describe 'example 1' do
      let(:command_file_content) do
        <<~eos
          PLACE 0,0,NORTH
          MOVE
          REPORT
        eos
      end

      it { is_expected.to eq "0,1,NORTH\n" }
    end

    describe 'example 2' do
      let(:command_file_content) do
        <<~eos
          PLACE 0,0,NORTH
          LEFT
          REPORT
        eos
      end

      it { is_expected.to eq "0,0,WEST\n" }
    end

    describe 'example 3' do
      let(:command_file_content) do
        <<~eos
          PLACE 1,2,EAST
          MOVE
          MOVE
          LEFT
          MOVE
          REPORT
        eos
      end

      it { is_expected.to eq "3,3,NORTH\n" }
    end
  end

  describe 'integration tests' do
    describe 'walk off edge multiple times' do
    let(:command_file_content) do
        <<~eos
          PLACE 2,0,EAST
          MOVE
          MOVE
          MOVE
          MOVE
          MOVE
          REPORT
        eos
    end

    it { is_expected.to eq "4,0,EAST\n" }
  end

  describe 'turn all the way around and back agin' do
    let(:command_file_content) do
        <<~eos
          PLACE 0,0,EAST
          LEFT
          LEFT
          LEFT
          LEFT
          RIGHT
          RIGHT
          RIGHT
          RIGHT
          REPORT
        eos
    end

    it { is_expected.to eq "0,0,EAST\n" }
  end


  describe 'multiple reports' do
    let(:command_file_content) do
        <<~eos
          PLACE 0,4,SOUTH
          MOVE
          REPORT
          MOVE
          REPORT
        eos
    end

    it { is_expected.to eq "0,3,SOUTH\n0,2,SOUTH\n" }
  end

  describe 'ignores commands unless placed' do
    let(:command_file_content) do
      <<~eos
        LEFT
        RIGHT
        MOVE
        REPORT
      eos
    end

    it { is_expected.to eq "" }
  end

  describe 'ignores commands when placed off board' do
    let(:command_file_content) do
      <<~eos
        PLACE 20,30,NORTH
        LEFT
        RIGHT
        MOVE
        REPORT
      eos
    end

    it { is_expected.to eq "" }
  end

  describe 'long obscure walk' do
    let(:command_file_content) do
      <<~eos
        PLACE 4,4,NORTH
        RIGHT
        RIGHT
        MOVE
        MOVE
        RIGHT
        MOVE
        LEFT
        MOVE
        MOVE
        MOVE
        REPORT
      eos
    end

    it { is_expected.to eq "3,0,SOUTH\n" }
  end
end

end
