require 'gosu'
require 'pry'

require_relative 'lib/berries'
require_relative 'lib/berry'
require_relative 'lib/berry_configs'
require_relative 'lib/farmer'
require_relative 'lib/calendar'
require_relative 'lib/cursor'
require_relative 'lib/keys'
require_relative 'lib/bounding_box'


class Main < Gosu::Window

  include Keys
  include BerryConfig
  attr_reader :month, :basket
  attr_accessor :picked_berries

  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @farmer = Farmer.new(self, 550, 300)
    @calendar = Calendar.new(self, 30, 50)
    @cursor = Cursor.new(self, true)

    @basket = { yellow: 1, white: 1, black: 1, pink: 1,
                orange: 1, blue: 1, green: 1, gray: 1,
                red: 1, teal: 1, brown: 1, purple: 1 }

    @berry_images = Berries.new(self, 50, 300)
    @test_font = Gosu::Font.new(self, "Futura", 600 / 30)
    @locs = []

    @picked_berries = []

    @berries = []
    @berry_configs = [orange_config, green_config, pink_config]
    build_berries
  end

  def build_berries
    @berry_configs.each do |config|
      @berries << Berry.new(config)
    end
  end

  def draw_text(x, y, text, font)
    font.draw(text, x, y, 1, 1, 1, Gosu::Color::BLACK)
  end

  def needs_cursor?
    true
  end

  def update
    @calendar.update

    berry_picked?
    @berries.each { |b| b.update }
  end

  def draw
    @farmer.draw
    @calendar.draw
    # @berry_images.draw
    @cursor.draw
    @berries.each { |b| b.draw }
    @picked_berries.map {|b| b.y = 100}
    @picked_berries.each {|b| b.draw}
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

  def berry_picked?
    @berries.each do |berry|
      @locs.each do |location|
        if berry.bounds.collide?(location[0], location[1])

          if berry.state != :selected && berry.state != :undecided
            berry.state = :selected
            @locs.clear
          else
            berry.state = :deselected
            @locs.clear
          end
          
        end
      end
    end
  end

end

Main.new.show
