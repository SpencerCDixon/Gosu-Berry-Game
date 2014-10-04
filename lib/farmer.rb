class Farmer

  attr_accessor :state, :berry1, :berry2, :harvest

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @farmer = Gosu::Image.new(window, 'img/farmer.png')
    @text_bubble = Gosu::Image.new(window, 'img/text_bubble.png')
    @test_font = Gosu::Font.new(window, "Futura", 600 / 20)
    @state = :intro
    @berry1 = {}
    @berry2 = {}
    @harvest = {}
  end

  def draw
    @farmer.draw(@x, @y, 0)
    @text_bubble.draw(@x - 100, @y - 250, 0)

    case @state
    when :intro
      intro
    when :receipt
      receipt
    when :harvest
      harvest
    end
  end

  def intro
    draw_text(480, 190, "Intro Text goes here.", @test_font, Gosu::Color::BLACK)
  end

  def receipt
    draw_text(480, 190, "#{@berry1[:color].capitalize} sold for #{@berry1[:amount_sold_for]}", @test_font, Gosu::Color::BLACK)
    draw_text(480, 220, "#{@berry2[:color].capitalize} sold for #{@berry2[:amount_sold_for]}", @test_font, Gosu::Color::BLACK)
  end

  def harvest
    draw_text(480, 190, "You got #{@harvest[:amount]} #{@harvest[:color].to_s.capitalize}", @test_font, Gosu::Color::BLACK)
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end

end
