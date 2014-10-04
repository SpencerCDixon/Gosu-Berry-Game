class Farmer

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @farmer = Gosu::Image.new(window, 'img/farmer.png')
    @text_bubble = Gosu::Image.new(window, 'img/text_bubble.png')
  end

  def draw
    @farmer.draw(@x, @y, 0)
    @text_bubble.draw(@x - 100, @y - 250, 0)
  end

  def recept(berry_color, sale_price)

  end



end
