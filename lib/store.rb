require_relative 'sku'
require_relative 'sku_configs'

class Store

  attr_accessor :stock
  include SkuConfigs

  def initialize(window, x, y)
    @window = window

    @bg = Gosu::Image.new(window, "img/store_bg.png")

    @stock = []

    @nitrogen = SkuFactory.new(nitrogen)
    @potassium = SkuFactory.new(potassium)
    @phosphorus = SkuFactory.new(phosphorus)
    @nitrogen.state = :selected
    @stock << @nitrogen
    @stock << @potassium
    @stock << @phosphorus

  end

  def update

  end

  def draw
    @bg.draw(0,0,0)
    # @potassium.draw(380, 250, 1)
    # @nitrogen.draw(250, 250, 1)
    # @phosphorus.draw(170, 250, 1)
    @stock.each do |item|
      if item.state == :selected
        item.x = 50
        item.y = 480
        item.draw
      else
        item.draw
      end
    end
  end

end
