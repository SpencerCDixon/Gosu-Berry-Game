module Keys

  def button_down(id)
    case id
    when Gosu::MsLeft
      @locs << [mouse_x, mouse_y]
    when Gosu::KbReturn
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


      if @calendar.day_count >= 30
        if @fertilzer != :empty
          @fertilizer = :empty
        end
        @calendar.day_count = 0
        @calendar.month_count += 1
      end

        @calendar.day_count += (6 - @helpers - @tractor)
        @picked_berries.clear
        @berries.each { |b| b.state = :unselected }
        @locs.clear
      end
    when Gosu::KbSpace
      if @picked_berries.size == 2
        b1 = @picked_berries[0].color
        b2 = @picked_berries[1].color
        @basket[b1.to_sym] -= 1
        @basket[b2.to_sym] -= 1

        if @calendar.day_count >= 30
          if @fertilzer != :empty
            @fertilizer = :empty
          end
          @calendar.day_count = 0
          @calendar.month_count += 1
        end
        @calendar.day_count += (6 - @helpers)
        generate_correct_berry(combine_berries(@picked_berries[0], @picked_berries[1]), @calendar.month_count) if @picked_berries.size > 0

        @picked_berries.clear
        @berries.each { |b| b.state = :unselected }
        @locs.clear
      end
    end
  end

end
