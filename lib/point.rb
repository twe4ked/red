class Point
  def initialize coordinates: [0, 0], width:
    @x, @y = *coordinates
    @width = width
  end

  def coordinates
    [x, y]
  end

  def right
    new_x = x + 1
    new_y = y

    if x >= 9
      new_y += 1
      new_x = 0
    end

    Point.new coordinates: [new_x, new_y], width: width
  end

  def left
    new_x = x - 1
    new_y = y

    if x == 0
      new_y -= 1
      new_x = width
    end

    Point.new coordinates: [new_x, new_y], width: width
  end

  def beginning_of_line?
    x == 0
  end

  private

  attr_reader :x, :y, :width
end
