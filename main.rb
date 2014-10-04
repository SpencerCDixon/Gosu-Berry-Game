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
require_relative 'lib/buttons'

class Main < Gosu::Window

  include Keys
  include BerryConfig
  attr_reader :month, :basket, :selected, :month_count, :calendar, :berry_configs
  attr_accessor :picked_berries

  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @bg = Gosu::Image.new(self, "img/bg.gif")

    @farmer = Farmer.new(self, 550, 400)
    @calendar = Calendar.new(self, 30, 30)
    @cursor = Cursor.new(self, true)
    @button_reset = Buttons.new(self, 90, 480, "reset")
    @button_combine = Buttons.new(self, 340, 480, "combine")
    @button_sell = Buttons.new(self, 220, 480, "sell")


    @basket = { yellow: 5, white: 5, black: 5, pink: 0,
                orange: 0, blue: 0, green: 0, gray: 0,
                red: 0, teal: 0, brown: 0, purple: 0 }

    @berry_images = Berries.new(self, 50, 300)
    @test_font = Gosu::Font.new(self, "Futura", 600 / 30)
    @farmer_font = Gosu::Font.new(self, "Futura", 600 / 20)

    @locs = []

    @picked_berries = []
    @selected = 0

    @berries = []
    @berry_configs = [orange_config, green_config, pink_config, red_config, yellow_config, white_config, black_config, teal_config, brown_config, purple_config, gray_config, blue_config]
    build_berries


    @money = 0
  end

  def build_berries
    @berry_configs.each do |config|
      @berries << Berry.new(config)
    end
  end

  def update
    @calendar.update

    berry_picked?
    reset_berries?
    combine_berries?
    sell_berries?
    @berries.each { |b| b.update }
  end

  def draw
    @berry_images.draw
    @bg.draw(0, 0, 0)
    @button_reset.draw
    @button_combine.draw
      @button_sell.draw

    @farmer.draw
    @calendar.draw
    @cursor.draw
    @berries.each { |b| b.draw }

    draw_text(510, 185, "Berry 1 = #{@picked_berries[0].color.capitalize}", @farmer_font, Gosu::Color::BLACK) if @picked_berries.size > 0
    draw_text(510, 235, "Berry 2 = #{@picked_berries[1].color.capitalize}", @farmer_font, Gosu::Color::BLACK) if @picked_berries.size > 1
    draw_text(85, 560, "Reset Berries", @test_font, Gosu::Color::BLACK)
    draw_text(330, 560, "Combine Berries", @test_font, Gosu::Color::BLACK)
    draw_text(220, 560, "Sell Berries", @test_font, Gosu::Color::BLACK)

    draw_text(670, 30, "money #{@money}", @test_font, Gosu::Color::BLACK)
    draw_text(620, 30, "month count #{@calendar.month_count}", @test_font, Gosu::Color::RED)

  end

  def combine_berries(berry1, berry2)
    final_berry = []

    case
    when berry1.type == :very_rare
      final_berry << berry1.genetics[0..1]
      final_berry.flatten!
    when berry1.type == :rare
      counts = Hash.new(0)
      berry1.genetics.each { |name| counts[name] += 1}
      biggest = counts.max_by { |k, v| v }
      final_berry << biggest[0]
      final_berry << ["x", "y", "z"].sample
    when berry1.type == :uncommon
      final_berry << berry1.genetics.uniq
      final_berry.flatten!
    when berry1.type == :common
      counts = Hash.new(0)
      berry1.genetics.each { |name| counts[name] += 1}
      biggest = counts.max_by { |k, v| v }
      final_berry << biggest[0]

      final_berry << berry1.genetics.uniq.sample
    end

    case
    when berry2.type == :very_rare
      final_berry << berry2.genetics[0..1]
      final_berry.flatten!
    when berry2.type == :rare
      counts = Hash.new(0)
      berry2.genetics.each { |name| counts[name] += 1}
      biggest = counts.max_by { |k, v| v }
      final_berry << biggest[0]
      final_berry << ["x", "y", "z"].sample

    when berry2.type == :uncommon
      final_berry << berry2.genetics.uniq
      final_berry.flatten!
    when berry2.type == :common
      counts = Hash.new(0)
      berry2.genetics.each { |name| counts[name] += 1}
      biggest = counts.max_by { |k, v| v }
      final_berry << biggest[0]

      final_berry << berry2.genetics.uniq.sample
    end

    final_berry
  end

  def generate_correct_berry(array, current_month)
    array.sort!
    case
    when array == ["x", "y", "y", "y"] || array == ["y", "y", "y", "z"]
      @basket[:yellow] += growth_rate(current_month, yellow_config[:prime_month], yellow_config[:type] )
    when array == ["x", "x", "x", "y"] || array == ["x", "x", "x", "z"]
      @basket[:white] += growth_rate(current_month, white_config[:prime_month], yellow_config[:type] )
    when array == ["x", "z", "z", "z"] || array == ["y", "z", "z", "z"]
      @basket[:black] += growth_rate(current_month, black_config[:prime_month], yellow_config[:type] )
    when array == ["x", "x", "y", "y"]
      @basket[:green] += growth_rate(current_month, green_config[:prime_month], yellow_config[:type] )
    when array == ["y", "y", "z", "z"]
      @basket[:red] += growth_rate(current_month, red_config[:prime_month], yellow_config[:type] )
    when array == ["x", "x", "z", "z"]
      @basket[:gray] += growth_rate(current_month, gray_config[:prime_month], yellow_config[:type] )
    when array == ["x", "y", "y", "z"]
      @basket[:brown] += growth_rate(current_month, brown_config[:prime_month], yellow_config[:type] )
    when array == ["x", "x", "y", "z"]
      @basket[:teal] += growth_rate(current_month, teal_config[:prime_month], yellow_config[:type] )
    when array == ["x", "y", "z", "z"]
      @basket[:purple] += growth_rate(current_month, purple_config[:prime_month], yellow_config[:type] )
    when array == ["y", "y", "y", "y"]
      @basket[:orange] += growth_rate(current_month, orange_config[:prime_month], yellow_config[:type] )
    when array == ["x", "x", "x", "x"]
      @basket[:pink] += growth_rate(current_month, pink_config[:prime_month], yellow_config[:type] )
    when array == ["z", "z", "z", "z"]
      @basket[:blue] += growth_rate(current_month, blue_config[:prime_month], yellow_config[:type] )
    end
  end

  def berry_picked?
    @berries.each do |berry|
      @locs.each do |location|
        if berry.bounds.collide?(location[0], location[1])
          if berry.state != :selected
            berry.state = :selected
            if @selected >= 3
              @selected = 0
            end
            @selected += 1
            @picked_berries << berry
            @locs.clear
          else
            berry.state = :deselected
            @locs.clear
          end
        end
      end
    end
  end

  def reset_berries?
    @locs.each do |location|
      if @button_reset.bounds.collide?(location[0], location[1])
        @picked_berries.clear
        @berries.each { |b| b.state = :unselected }
      end
    end
  end

  def combine_berries?
    @locs.each do |location|
      if @button_combine.bounds.collide?(location[0], location[1])
        b1 = @picked_berries[0].color
        b2 = @picked_berries[1].color
        @basket[b1.to_sym] -= 1
        @basket[b2.to_sym] -= 1
        if @calendar.day_count == 5
          @calendar.day_count = 0
          @calendar.month_count += 1
        end
        @calendar.day_count += 1
        generate_correct_berry(combine_berries(@picked_berries[0], @picked_berries[1]), @calendar.month_count) if @picked_berries.size > 0

        @picked_berries.clear
        @berries.each { |b| b.state = :unselected }
        @locs.clear
      end
    end
  end

  def growth_rate(current_month, prime_month, type_of_berry)
    case type_of_berry
      when :common
        down_by_rate = 0.5
        max = 4
      when :uncommon
        down_by_rate = 1.0
        max = 6
      when :rare
        down_by_rate = 1.0
        max = 5
      when :very_rare
        down_by_rate = 2.0
        max = 7
    end
    value = max - (6 - ((prime_month - current_month).abs - 6).abs) * down_by_rate
    value < 0 ? 0 : value.to_i
  end

  def sell_berries?
    @locs.each do |location|
      if @button_sell.bounds.collide?(location[0], location[1])
        if @picked_berries.size == 2
        @money += @picked_berries[0].current_sale_value(@calendar.month_count, @picked_berries[0].prime_sell_month, @picked_berries[0].type)
        @money += @picked_berries[1].current_sale_value(@calendar.month_count, @picked_berries[1].prime_sell_month, @picked_berries[1].type)



        b1 = @picked_berries[0].color
        b2 = @picked_berries[1].color
        @basket[b1.to_sym] -= 1
        @basket[b2.to_sym] -= 1

        end

        if @calendar.day_count == 5
          @calendar.day_count = 0
          @calendar.month_count += 1
        end

        @calendar.day_count += 1
        @picked_berries.clear
        @berries.each { |b| b.state = :unselected }
        @locs.clear
      end
    end
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 1, 1, 1, color)
  end

  def needs_cursor?
    true
  end

end

Main.new.show
