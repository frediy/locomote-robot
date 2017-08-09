class Robot
  attr_reader :output, :x, :y, :facing

  def place(x, y, facing)
    if on_board?(x, y) && valid_facing?(facing)
      @x = x
      @y = y
      @facing = facing
    end
  end

  def move
    new_x, new_y = @x, @y
    case @facing
    when 'NORTH'
      new_y += 1
    when 'EAST'
      new_x += 1
    when 'SOUTH'
      new_y -= 1
    when 'WEST'
      new_x -= 1
    end
    @x, @y = new_x, new_y if on_board?(new_x, new_y)
  end

  def left
  end

  def right
  end

  def process_command!(command)
  end

  def output?
  end

  def clear_output!
  end

private

  def on_board?(x, y)
    0 <= x && x <= 4 &&
    0 <= y && y <= 4
  end

  def valid_facing?(facing)
    ['NORTH', 'EAST', 'SOUTH', 'WEST'].include?(facing)
  end
end

