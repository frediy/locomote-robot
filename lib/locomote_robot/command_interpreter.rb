class CommandInterpreter
  def initialize(robot)
    @robot = robot
  end

  def process_command(command)
    keyword, x, y, facing = keyword_and_arguments_from_command(command)

    case keyword
    when 'PLACE'
      @robot.place(x, y, facing)
    end
  end

private

  def keyword_and_arguments_from_command(command)
    keyword, arguments = command.split(' ')
    arguments = arguments.split(',')
    x = arguments[0].to_i
    y = arguments[1].to_i
    facing = arguments[2]

    [keyword, x, y, facing]
  end
end