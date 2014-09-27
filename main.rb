require 'gosu'

require_relative 'lib/berry'
require_relative 'lib/farmer'



class Main < Gosu::Window

  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @farmer = Farmer.new(self, 550, 300)


    @month = :january
  end

  def update

  end

  def draw
    @farmer.draw
  end

end

Main.new.show
