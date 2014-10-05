class SkuFactory

  attr_reader :type, :featured_x, :featured_y
  attr_accessor :x, :y, :z, :state, :name, :shop_quantity, :bankrupt, :already_purchased

  def initialize(args)
    @name = args[:name]
    @image = Gosu::Image.new(args[:window], "img/store/#{args[:image_link]}")
    @window = args[:window]
    @original_x = args[:x]
    @featured_x = 50
    @original_y = args[:y]
    @featured_y = 480
    @z = args[:z] || 0
    @description = args[:description] || "None"
    @state = :unselected
    @shop_quantity = args[:quantity]
    @player_quantity = 0
    @height = args[:height]
    @width = args[:width]
    @type = args[:type]
    @bankrupt = false
    @already_purchased = false

    @test_font = Gosu::Font.new(@window, "Futura", 600 / 30)
  end

  def bounds
    BoundingBox.new(@original_x, @original_y, @width, @height)
  end

  def draw
    if @state == :selected
      @image.draw(@featured_x, @featured_y, @z)
      draw_text(@featured_x + 110, @featured_y + 40, "#{@description}", @test_font, 0xffffffff)
      if @bankrupt
        draw_text(@featured_x + 110, @featured_y + 60, "Not enough money, time to sell some berries!", @test_font, Gosu::Color::RED)
      end
      if @already_purchased
        draw_text(@featured_x + 110, @featured_y + 60, "You can't get anymore", @test_font, Gosu::Color::RED)
      end
    else
      @image.draw(@original_x, @original_y, @z)
    end
  end

  def update
    purchased?
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 1, 1, 1, color)
  end


end
