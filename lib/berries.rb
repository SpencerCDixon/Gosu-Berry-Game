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
