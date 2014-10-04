class SkuFactory

  attr_accessor :x, :y, :z, :state

  def initialize(args)
    @name = args[:name]
    @image = Gosu::Image.new(args[:window], "img/store/#{args[:image_link]}")
    @window = args[:window]
    @x = args[:x]
    @y = args[:y]
    @z = args[:z] || 0
    @description = args[:description] || "None"
    @state = :unselected
    @shop_quantity = args[:quantity]
    @player_quantity = 0
    @height = args[:height]
    @width = args[:width]
  end

  def bounds
    BoundingBox.new(@x, @y, width, height)
  end

  def draw
    @image.draw(@x, @y, @z)
  end

  def update

  end

end
