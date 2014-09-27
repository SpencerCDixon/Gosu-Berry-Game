class Calendar

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y

    @january = Gosu::Image.new(window, 'img/calendar/january.png')
    @february = Gosu::Image.new(window, 'img/calendar/february.png')
    @march = Gosu::Image.new(window, 'img/calendar/march.png')
    @april = Gosu::Image.new(window, 'img/calendar/april.png')
    @may = Gosu::Image.new(window, 'img/calendar/may.png')
    @june = Gosu::Image.new(window, 'img/calendar/june.png')
    @july = Gosu::Image.new(window, 'img/calendar/july.png')
    @august = Gosu::Image.new(window, 'img/calendar/august.png')
    @september = Gosu::Image.new(window, 'img/calendar/september.png')
    @october = Gosu::Image.new(window, 'img/calendar/october.png')
    @november = Gosu::Image.new(window, 'img/calendar/november.png')
    @december = Gosu::Image.new(window, 'img/calendar/december.png')

  end

  def draw
    case
    when @window.month == :january
      @january.draw(@x, @y, 0)
    when @window.month == :february
      @february.draw(@x, @y, 0)
    when @window.month == :march
      @march.draw(@x, @y, 0)
    when @window.month == :april
      @april.draw(@x, @y, 0)
    when @window.month == :may
      @may.draw(@x, @y, 0)
    when @window.month == :june
      @june.draw(@x, @y, 0)
    when @window.month == :july
      @july.draw(@x, @y, 0)
    when @window.month == :august
      @august.draw(@x, @y, 0)
    when @window.month == :september
      @september.draw(@x, @y, 0)
    when @window.month == :october
      @october.draw(@x, @y, 0)
    when @window.month == :november
      @november.draw(@x, @y, 0)
    when @window.month == :december
      @december.draw(@x, @y, 0)
    end
  end

end
