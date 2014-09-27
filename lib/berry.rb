class Berry

  attr_accessor :x, :y, :state

  def initialize(args)
    @window = args[:window]
    @x = args[:x]
    @y = args[:y]
    @color = args[:color]
    @genetics = args[:genetics]
    @cols = args[:cols]

    @berry_img = Gosu::Image.new(@window, "img/berries/#{@color}_berry.png")

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

  def picked?
    @state == :selected
  end

  def unpicked?
    @state == :deselected
  end

  def bounds
    BoundingBox.new(@x, @y, 48, 44)
  end

  def draw
    if @window.basket[@color.to_sym] >= 1
      @berry_img.draw(@x, @y, 0)
    end
  end

  def update
    if picked?
      if @window.picked_berries.size >= 2
        @window.picked_berries << self.dup

      else
        @window.picked_berries << self.dup
      end
      @state = :undecided
    end

    if unpicked?
      @y = @y - 100
      @window.picked_berries.delete(self)

      @state = :undecided
    end
  end

end
