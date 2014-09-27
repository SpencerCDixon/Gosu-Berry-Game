require 'gosu'

require_relative 'lib/berry'
require_relative 'lib/farmer'
require_relative 'lib/calendar'



class Main < Gosu::Window
attr_reader :month
  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @farmer = Farmer.new(self, 550, 300)
    @calendar = Calendar.new(self, 30, 30)

  end

  def update
    @calendar.update

  end

  def draw
    @farmer.draw
    @calendar.draw
  end

end

Main.new.show
