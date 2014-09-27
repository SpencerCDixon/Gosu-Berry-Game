require 'gosu'
require 'pry'

require_relative 'lib/berry'
require_relative 'lib/farmer'
require_relative 'lib/calendar'



class Main < Gosu::Window

  attr_reader :month, :basket

  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @farmer = Farmer.new(self, 550, 300)
    @calendar = Calendar.new(self, 30, 50)

    @basket = { yellow: 1, white: 1, black: 1, pink: 1,
                orange: 1, blue: 1, green: 1, gray: 1,
                red: 1, teal: 1, brown: 1, purple: 1 }

    @berry_images = Berries.new(self, 50, 300)

  end

  def update
    @calendar.update

  end

  def draw
    @farmer.draw
    @calendar.draw
    @berry_images.draw
  end


  def combine_berries(berry1, berry2)

  end

  def generate_correct_berry(array)
    array.sort!
    case
    when array == ["x", "y", "y", "y"] || ["y", "y", "y", "z"]
      return "yellow"
    end
  end

end

Main.new.show
