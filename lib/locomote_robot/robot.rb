class Robot
  attr_reader :output, :x, :y, :facing

  NORTH = 'NORTH'
  EAST = 'EAST'
  SOUTH = 'SOUTH'
  WEST = 'WEST'

  VALID_FACINGS = [NORTH, EAST, SOUTH, WEST]

  def place(x, y, facing)
    # TODO: refactor conditional to method valid_place?
    if on_board?(x, y) && valid_facing?(facing) # TODO: add valid_coordinates?(x, y)
      @x = x
      @y = y
      @facing = facing
    end
  end

  def unplaced?
    @x      == nil ||
    @y      == nil ||
    @facing == nil
  end

  def move
    new_x, new_y = @x, @y

    case @facing
    when NORTH
      new_y += 1
    when EAST
      new_x += 1
    when SOUTH
      new_y -= 1
    when WEST
      new_x -= 1
    end

    @x, @y = new_x, new_y if on_board?(new_x, new_y)
  end

  def left
    # binding.pry
    return if unplaced?
    # binding.pry

    case @facing
    when NORTH
      @facing = WEST
    when EAST
      @facing = NORTH
    when SOUTH
      @facing = EAST
    when WEST
      @facing = SOUTH
    end
  end

  def right
    return if unplaced?

    case @facing
    when NORTH
      @facing = EAST
    when EAST
      @facing = SOUTH
    when SOUTH
      @facing = WEST
    when WEST
      @facing = NORTH
    end
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
    VALID_FACINGS.include?(facing)
  end
end
