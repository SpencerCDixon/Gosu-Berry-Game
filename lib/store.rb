class Store

  attr_accessor :stock

  def initialize(window, x, y)
    @window = window

    @stock = { hoe: 0, fetilizer: 3 }
    @bg = Gosu::Image.new(window, "img/store_bg.png")
  end

  def update

  end

  def draw
    @bg.draw(0,0,0)
  end

end
