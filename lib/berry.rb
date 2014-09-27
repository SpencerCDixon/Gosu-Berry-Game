class Berry
attr_accessor :x, :y
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @berry = Gosu::Image.new(window, 'img/berries/red_berry.png')
  end

  def draw
    @berry.draw(@x, @y, 0)
  end

  def update
    @x += 1
    @y -= 3
  end

end
