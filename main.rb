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
require_relative 'lib/store'


class Main < Gosu::Window

  include Keys
  include BerryConfig
  attr_reader :month, :basket, :selected, :month_count, :calendar, :berry_configs, :farmer
  attr_accessor :picked_berries, :locs, :button_buy, :fertilizer, :money, :hoe

  def initialize
    super(800, 600, false)
    self.caption = "Berry Game"

    @bg = Gosu::Image.new(self, "img/bg.gif")
    @store = Store.new(self, 0, 0)
    @farmer = Farmer.new(self, 550, 400)
    @calendar = Calendar.new(self, 30, 30)
    @cursor = Cursor.new(self, true)
    @button_reset = Buttons.new(self, 90, 480, "reset")
    @button_combine = Buttons.new(self, 340, 480, "combine")
    @button_sell = Buttons.new(self, 220, 480, "sell")
    @button_store = Buttons.new(self, 460, 480, "store")
    @button_game = Buttons.new(self, 650, 480, "store")
    @button_buy = Buttons.new(self, 550, 480, "sell")


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

    @money = 2000
    @fertilizer = :empty
    @hoe = false
    @state = :running
  end

  def build_berries
    @berry_configs.each do |config|
      @berries << Berry.new(config)
    end
  end

  def update
    if @state == :store
      back_to_game?
      @store.update
    else
      @calendar.update
      berry_picked?
      reset_berries?
      combine_berries?
      sell_berries?
      go_to_store?
      @berries.each { |b| b.update }
    end

    purchased_items?
  end

  def draw
    @cursor.draw

    if @state == :store
      @store.draw
      @button_game.draw
      @button_buy.draw
      draw_text(665, 560, "Return", @test_font, Gosu::Color::RED)
      draw_text(555, 560, "Buy Item", @test_font, Gosu::Color::RED)


    else
      @berry_images.draw
      @bg.draw(0, 0, 0)
      @button_reset.draw
      @button_combine.draw
      @button_sell.draw
      @button_store.draw

      @farmer.draw
      @calendar.draw
      @berries.each { |b| b.draw }

      draw_text(510, 185, "Berry 1 = #{@picked_berries[0].color.capitalize}", @farmer_font, Gosu::Color::BLACK) if @picked_berries.size > 0
      draw_text(510, 235, "Berry 2 = #{@picked_berries[1].color.capitalize}", @farmer_font, Gosu::Color::BLACK) if @picked_berries.size > 1
      draw_text(85, 560, "Reset Berries", @test_font, Gosu::Color::BLACK)
      draw_text(330, 560, "Combine Berries", @test_font, Gosu::Color::BLACK)
      draw_text(220, 560, "Sell Berries", @test_font, Gosu::Color::BLACK)
      draw_text(480, 560, "Store", @test_font, Gosu::Color::BLACK)


      draw_text(670, 30, "Money $#{@money}", @test_font, Gosu::Color::BLACK)
      draw_text(555, 560, "#{@fertilizer}", @test_font, Gosu::Color::RED)

      purchased_items?

    end

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

      if [3, 4, 5, 6].include?(@calendar.month_count)
        final_berry << "y"
      elsif [7,8,9,10].include?(@calendar.month_count)
        final_berry << "z"
      else
        final_berry << "x"
      end
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

      if [3, 4, 5, 6].include?(@calendar.month_count)
        final_berry << "y"
      elsif [7,8,9,10].include?(@calendar.month_count)
        final_berry << "z"
      else
        final_berry << "x"
      end
    end

    final_berry
  end

  def generate_correct_berry(array, current_month)
    @farmer.state = :harvest
    array.sort!
    case
    when array == ["x", "y", "y", "y"] || array == ["y", "y", "y", "z"]
      amount = growth_rate(current_month, yellow_config[:prime_month], yellow_config[:type], :yellow)
      @basket[:yellow] += amount
      @farmer.harvest = { color: :yellow, amount: amount}

    when array == ["x", "x", "x", "y"] || array == ["x", "x", "x", "z"]
      amount = growth_rate(current_month, white_config[:prime_month], white_config[:type], :white )
      @basket[:white] += amount
      @farmer.harvest = { color: :white, amount: amount}

    when array == ["x", "z", "z", "z"] || array == ["y", "z", "z", "z"]
      amount = growth_rate(current_month, black_config[:prime_month], black_config[:type], :black )
      @basket[:black] += amount
      @farmer.harvest = { color: :black, amount: amount}

    when array == ["x", "x", "y", "y"]
      amount = growth_rate(current_month, green_config[:prime_month], green_config[:type], :green )
      @basket[:green] += amount
      @farmer.harvest = { color: :green, amount: amount}

    when array == ["y", "y", "z", "z"]
      amount = growth_rate(current_month, red_config[:prime_month], red_config[:type], :red )
      @basket[:red] += amount
      @farmer.harvest = { color: :red, amount: amount}

    when array == ["x", "x", "z", "z"]
      amount = growth_rate(current_month, gray_config[:prime_month], gray_config[:type], :gray )
      @basket[:gray] += amount
      @farmer.harvest = { color: :gray, amount: amount}

    when array == ["x", "y", "y", "z"]
      amount = growth_rate(current_month, brown_config[:prime_month], brown_config[:type], :brown )
      @basket[:brown] += amount
      @farmer.harvest = { color: :brown, amount: amount}

    when array == ["x", "x", "y", "z"]
      amount = growth_rate(current_month, teal_config[:prime_month], teal_config[:type], :teal )
      @basket[:teal] += amount
      @farmer.harvest = { color: :teal, amount: amount}

    when array == ["x", "y", "z", "z"]
      amount = growth_rate(current_month, purple_config[:prime_month], purple_config[:type], :purple )
      @basket[:purple] += amount
      @farmer.harvest = { color: :purple, amount: amount}

    when array == ["y", "y", "y", "y"]
      amount = growth_rate(current_month, orange_config[:prime_month], orange_config[:type], :orange )
      @basket[:orange] += amount
      @farmer.harvest = { color: :orange, amount: amount}

    when array == ["x", "x", "x", "x"]
      amount = growth_rate(current_month, pink_config[:prime_month], pink_config[:type], :pink )
      @basket[:pink] += amount
      @farmer.harvest = { color: :pink, amount: amount}

    when array == ["z", "z", "z", "z"]
      amount = growth_rate(current_month, blue_config[:prime_month], blue_config[:type], :blue )
      @basket[:blue] += amount
      @farmer.harvest = { color: :blue, amount: amount}
    end
  end

  def berry_picked?
    @berries.each do |berry|
      @locs.each do |location|
        if berry.bounds.collide?(location[0], location[1])
          if berry.state != :selected
            berry.state = :selected
            @farmer.state = :selected
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

  def go_to_store?
    @locs.each do |location|
      if @button_store.bounds.collide?(location[0], location[1])
        @state = :store
        @locs.clear
      end
    end
  end

  def back_to_game?
    @locs.each do |location|
      if @button_game.bounds.collide?(location[0], location[1])
        @state = :running
        @locs.clear
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
          if @fertilzer != :empty
            @fertilizer = :empty
          end
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

  def sell_berries?
    @locs.each do |location|
      if @button_sell.bounds.collide?(location[0], location[1])
        if @picked_berries.size == 2
          berry_1_sell = @picked_berries[0].current_sale_value(@calendar.month_count, @picked_berries[0].prime_sell_month, @picked_berries[0].type)
          @money += berry_1_sell
          @farmer.berry1 = { color: @picked_berries[0].color, amount_sold_for: berry_1_sell }

          berry_2_sell = @picked_berries[1].current_sale_value(@calendar.month_count, @picked_berries[1].prime_sell_month, @picked_berries[1].type)
          @money += berry_2_sell
          @farmer.berry2 = { color: @picked_berries[1].color, amount_sold_for: berry_2_sell }

          b1 = @picked_berries[0].color
          b2 = @picked_berries[1].color
          @basket[b1.to_sym] -= 1
          @basket[b2.to_sym] -= 1
        end

        if @calendar.day_count == 5
          if @fertilzer != :empty
            @fertilizer = :empty
          end
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

  def growth_rate(current_month, prime_month, type_of_berry, berry_color)
    case type_of_berry
      when :common
        down_by_rate = 0.51
        max = 5
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
    value = (max - (6 - ((prime_month - current_month).abs - 6).abs) * down_by_rate).to_i
    value += calc_fert(@fertilizer, berry_color).to_i
    if @hoe
      value += 1
    end
    value < 0 ? 0 : value
  end

  def calc_fert(fert_state, berry_color)
    nitrogen_boost = [:white, :green, :teal, :gray, :pink]
    potassium_boost = [:yellow, :red, :green, :brown, :orange]
    phosphorus_boost = [:black, :red, :gray, :purple, :blue]

    case fert_state
    when :nitrogen
      if nitrogen_boost.include?(berry_color)
        2
      end
    when :potassium
      if potassium_boost.include?(berry_color)
        2
      end
    when :phosphorus
      if phosphorus_boost.include?(berry_color)
        2
      end
    else
      0
    end
  end



  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 1, 1, 1, color)
  end

  def needs_cursor?
    true
  end

  def purchased_items?
    if @fertilizer == :nitrogen
      n = Gosu::Image.new(self, "img/store/nitrogen-small.png")
      n.draw(25,30,2)
    end
    if @fertilizer == :potassium
      n = Gosu::Image.new(self, "img/store/potassium-small.png")
      n.draw(25,30,2)
    end
    if @fertilizer == :phosphorus
      n = Gosu::Image.new(self, "img/store/phosphorus-small.png")
      n.draw(25,30,2)
    end
    if @hoe
      n = Gosu::Image.new(self, "img/store/hoe.png")
      n.draw(425,30,2)
    end
  end

end

Main.new.show
