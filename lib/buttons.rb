class Buttons

  def initialize(window, x, y, type)
    @window = window
    @x = x
    @y = y

    @button = Gosu::Image.new(window, "img/#{type}_button.png")
  end

  def bounds
    BoundingBox.new(@x, @y, 75, 75)
  end

  def draw
    @button.draw(@x, @y, 0)
  end

end
