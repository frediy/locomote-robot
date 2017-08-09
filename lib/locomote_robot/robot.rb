class Robot
  attr_reader :output, :x, :y, :facing

  NORTH = 'NORTH'
  EAST = 'EAST'
  SOUTH = 'SOUTH'
  WEST = 'WEST'

  VALID_FACINGS = [NORTH, EAST, SOUTH, WEST]

  def place(x, y, facing)
    if valid_place?(x, y, facing)
      @x = x
      @y = y
      @facing = facing
    end
  end

  def placed?
    @x != nil && @y != nil && @facing != nil
  end

  def move
    return unless placed?

    new_x, new_y = @x, @y

    case @facing
    when NORTH
      new_y += 1
    when EAST
      new_x += 1
    when SOUTH
      new_y -= 1
    else #WEST
      new_x -= 1
    end

    @x, @y = new_x, new_y if on_board?(new_x, new_y)
  end

  def left
    return unless placed?

    case @facing
    when NORTH
      @facing = WEST
    when EAST
      @facing = NORTH
    when SOUTH
      @facing = EAST
    else #WEST
      @facing = SOUTH
    end
  end

  def right
    return unless placed?

    case @facing
    when NORTH
      @facing = EAST
    when EAST
      @facing = SOUTH
    when SOUTH
      @facing = WEST
    else #WEST
      @facing = NORTH
    end
  end

private

  def valid_place?(x, y, facing)
    x.integer? &&
    y.integer? &&
    valid_facing?(facing) &&
    on_board?(x, y)
  end

  def valid_facing?(facing)
    VALID_FACINGS.include?(facing)
  end

  def on_board?(x, y)
    0 <= x && x <= 4 &&
    0 <= y && y <= 4
  end
end
