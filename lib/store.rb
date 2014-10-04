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
    @hoe = SkuFactory.new(hoe)
    @stock << @nitrogen
    @stock << @potassium
    @stock << @phosphorus
    @stock << @hoe

  end

  def update
    item_selected?
    purchased?
  end

  def draw
    @bg.draw(0,0,0)
    @stock.each do |item|
        item.draw
    end
  end

  def item_selected?
    @window.locs.each do |location|
      @stock.each do |item|
        if item.bounds.collide?(location[0], location[1])
          @stock.each do |item2|
            if item2.state == :selected
              item2.state = :unselected
            end
          end
          item.state = :selected
          @window.locs.clear
        end
      end
    end
  end

  def purchased?
    @window.locs.each do |location|
      if @window.button_buy.bounds.collide?(location[0], location[1])

        item = @stock.find { |b| b.state == :selected}

        if item.type == :fertilizer
          if @window.money >= 800
            @window.money -= 800
            @window.fertilizer = item.name
            item.state = :unselected
          else
            puts "not enough money"
          end
        end

        if item.name == :hoe
          if @window.money >= 2000
            @window.money -= 2000
            @window.hoe = true
            item.state = :unselected
          end
        end
        @window.locs.clear
      end
    end
  end

end
