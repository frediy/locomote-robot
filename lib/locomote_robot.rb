require 'locomote_robot/version'

require 'locomote_robot/robot'
require 'locomote_robot/command_interpreter'

module LocomoteRobot
  def self.root_directory
    File.dirname(__dir__)
  end

  def self.tmp_directory
    File.join(root_directory, 'tmp')
  end
end
