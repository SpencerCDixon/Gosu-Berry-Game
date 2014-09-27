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

    @time_counter = 0

    @months = [:january, :february, :march, :april,
               :may, :june, :july, :august, :september,
               :october, :november, :december]
    @current_month = @months[0]

  end

  def draw
    case
    when @current_month == :january
      @january.draw(@x, @y, 0)
    when @current_month == :february
      @february.draw(@x, @y, 0)
    when @current_month == :march
      @march.draw(@x, @y, 0)
    when @current_month == :april
      @april.draw(@x, @y, 0)
    when @current_month == :may
      @may.draw(@x, @y, 0)
    when @current_month == :june
      @june.draw(@x, @y, 0)
    when @current_month == :july
      @july.draw(@x, @y, 0)
    when @current_month == :august
      @august.draw(@x, @y, 0)
    when @current_month == :september
      @september.draw(@x, @y, 0)
    when @current_month == :october
      @october.draw(@x, @y, 0)
    when @current_month == :november
      @november.draw(@x, @y, 0)
    when @current_month == :december
      @december.draw(@x, @y, 0)
    end
  end

  def update
    @time_counter += 1

    if @time_counter % (60 * 5) == 0
      @current_month = @months[1]
    end
  end

end
