class Buttons

  def initialize(window, x, y, type)
    @window = window
    @x = x
    @y = y

    @button = Gosu::Image.new(window, "img/#{type}_button.png")
  end

  def bounds
    BoundingBox.new(@x, @y, 80, 80)
  end

  def draw
    @button.draw(@x, @y, 1)
  end

end
