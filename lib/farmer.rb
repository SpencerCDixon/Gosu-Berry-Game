class Farmer

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @farmer = Gosu::Image.new(window, 'img/farmer.png')
  end

  def draw
    @farmer.draw(@x, @y, 0)
  end

end
