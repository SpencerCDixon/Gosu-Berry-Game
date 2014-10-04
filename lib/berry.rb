class Berry

  attr_reader :type
  attr_accessor :x, :y, :state, :color, :genetics, :sell, :prime_month

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

    @berry_img = Gosu::Image.new(@window, "img/berries/#{@color}_berry.png")
    @test_font = Gosu::Font.new(@window, "Futura", 600 / 30)


    @spacing = 80
    @state = :unselected

    @x = @x + col(@cols)
  end

  def col(num)
    if num > 0
      @spacing * num
    else
      @spacing
    end
  end

  def bounds
    BoundingBox.new(@x, @y, 48, 44)
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

  def current_sale_value(current_month, prime_sell_month, rank_of_berry)
    value = get_maximum(rank_of_berry) - (6 - ((prime_sell_month - current_month).abs - 6).abs) * 75
    value < 0 ? 0 : value
  end

  def get_maximum(rank)
    if rank == :common
      200
    elsif rank == :uncommon
      300
    elsif rank == :rare
      400
    else
      500
    end
  end

  def growth_rate(current_month, prime_month, rank_of_berry)
    case rank_of_berry
      when :common
        down_by_rate = 0.5
        max = 4
      when :uncommon
        down_by_rate = 1.0
        max = 6
      when :rare
        down_by_rate = 1.0
        max = 5
      when :very_rare
        down_by_rate = 2.0
        max = 7
    end
    value = max - (6 - ((prime_month - current_month).abs - 6).abs) * down_by_rate
    value < 0 ? 0 : value
  end
end
