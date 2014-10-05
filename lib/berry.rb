class Berry

  attr_reader :type
  attr_accessor :x, :y, :state, :color, :genetics, :sell, :prime_month, :prime_sell_month, :type

  def initialize(args)
    @window = args[:window]
    @x = args[:x]
    @y = args[:y]
    @color = args[:color]
    @genetics = args[:genetics]
    @cols = args[:cols]
    @type = args[:type]
    @sell = args[:price]
    @prime_month = args[:prime_month]
    @prime_sell_month = args[:prime_sell_month]

    @berry_img = Gosu::Image.new(@window, "img/berries/#{@color}_berry.png")
    @test_font = Gosu::Font.new(@window, "Futura", 600 / 30)


    @spacing = 80
    @state = :unselected

    @x = @x + col(@cols) + 20
  end

  def col(num)
    if num > 0
      @spacing * num
    else
      @spacing
    end
  end

  def bounds
    BoundingBox.new(@x, @y, 40, 40)
  end

  def draw
    if @window.basket[@color.to_sym] >= 1
      @berry_img.draw(@x, @y, 0)
      draw_text(@x + 50, @y + 20, "x #{@window.basket[@color.to_sym]}", @test_font, Gosu::Color::BLACK)
    end
  end

  def update

  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end

  def current_sale_value(current_month, prime_sell_month, type_of_berry)
    @window.farmer.state = :receipt
    value = get_maximum(type_of_berry) - (6 - ((prime_sell_month - current_month).abs - 6).abs) * 75
    value < 0 ? 0 : value
  end

  def get_maximum(type)
    if type == :common
      200
    elsif type == :uncommon
      300
    elsif type == :rare
      400
    else
      500
    end
  end

end
