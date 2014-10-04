class Berries

  attr_accessor :x, :y
  attr_reader :yellow, :white, :black, :pink, :orange, :blue, :green, :gray, :red, :teal, :brown, :purple

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @yellow = Gosu::Image.new(window, 'img/berries/yellow_berry.png')
    @white = Gosu::Image.new(window, 'img/berries/white_berry.png')
    @black = Gosu::Image.new(window, 'img/berries/black_berry.png')
    @pink = Gosu::Image.new(window, 'img/berries/pink_berry.png')
    @orange = Gosu::Image.new(window, 'img/berries/orange_berry.png')
    @blue = Gosu::Image.new(window, 'img/berries/blue_berry.png')
    @green = Gosu::Image.new(window, 'img/berries/green_berry.png')
    @gray = Gosu::Image.new(window, 'img/berries/gray_berry.png')
    @red = Gosu::Image.new(window, 'img/berries/red_berry.png')
    @teal = Gosu::Image.new(window, 'img/berries/teal_berry.png')
    @brown = Gosu::Image.new(window, 'img/berries/brown_berry.png')
    @purple = Gosu::Image.new(window, 'img/berries/purple_berry.png')

    @quantity = Gosu::Font.new(@window, "Futura", 600 / 30)

    @space = 80
  end

  def col(num)
    if num > 0
      @space * num
    else
      @space
    end
  end

  def draw

    # if @window.basket[:yellow] >= 1
    #   @yellow.draw(@x, @y, 0)
    #   draw_text(@x + 50, @y + 20, "x #{@window.basket[:yellow]}", @quantity, 0xffffffff)
    # end
    #
    # if @window.basket[:white] >= 1
    #   @white.draw(@x + col(1), @y, 0)
    #   draw_text(@x + col(1) + 50, @y + 20, "x #{@window.basket[:white]}", @quantity, 0xffffffff)
    # end
    #
    # if @window.basket[:black] >= 1
    #   @black.draw(@x + col(2), @y, 0)
    #   draw_text(@x + col(2) + 50, @y + 20, "x #{@window.basket[:black]}", @quantity, 0xffffffff)
    # end
    #
    # @pink.draw(@x + col(3), @y, 0) if @window.basket[:pink] >= 1
    # @orange.draw(@x + col(4), @y, 0) if @window.basket[:orange] >= 1
    # @blue.draw(@x + col(5), @y, 0) if @window.basket[:blue] >= 1
    #
    # @green.draw(@x, @y + 60, 0) if @window.basket[:green] >= 1
    # @gray.draw(@x + col(1), @y + 60, 0) if @window.basket[:gray] >= 1
    # @red.draw(@x + col(2), @y + 60, 0) if @window.basket[:red] >= 1
    # @teal.draw(@x + col(3), @y + 60, 0) if @window.basket[:teal] >= 1
    # @brown.draw(@x + col(4), @y + 60, 0) if @window.basket[:brown] >= 1
    # @purple.draw(@x + col(5), @y + 60, 0) if @window.basket[:purple] >= 1

    # case @window.calendar.month_count
    # when 0
    #   berry_color = @window.berry_configs.select { |b| b[:prime_month] = 0 }
    #   send("#{berry_color.first[:color]}").draw(50, 50, 5)
    # end
    draw_calendar_berry(@window.calendar.month_count)
  end

  def draw_calendar_berry(month_count)
    @window.berry_configs.each do |config|
      if config[:prime_month] == month_count
        @draw_color = config[:color]
      end
    end
    send("#{@draw_color}").draw(150, 30, 5)
  end

  def update

  end

  def draw_text_centered(text, font, y_adjust, c)
    x = (800 - font.text_width(text)) / 2
    y = (600 - font.height) / 2
    y += y_adjust
    color = c
    draw_text(x, y, text, font, color)
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end


end
