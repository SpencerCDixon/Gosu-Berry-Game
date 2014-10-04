# Each berry grows must during prime month
# Each month away from the prime month it grows less and less


# Common:
# Prime = 4 and goes down by .5 in each direction for each month

# Uncommon:
# P = 5, -1

# Rare:
# P = 4, -1

# Very rare:
# p = 6
# -2

# common:

# if prime month berry output is prime
#   give prime output
# elsif figure out the distance from prime month >= 6
#   subtract berry output by distance from prime * down by rate
# elsif distance > 6 then find difference between distance and 6
#   add whatever that difference is times the go down by rate

def growth_rate(current_month, prime_month, rank_of_berry)
  case rank_of_berry
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
  value < 0 ? 0 : value
end


January = prime

Month = december

 5 * downbyrate + minimum

def calculate_growth(prime_month, current_month, down_by_rate, prime_starting_value)
  distance = prime_month - current_month

  if distance.abs > 6
    difference = distance - 6
    current_production = difference * down_by_rate
    minimum = prime_month - (6 * down_by_rate)
    final = current_production + minimum
  end

  final
end

def current_sale_value(current_month, prime_month, rank_of_berry)
  value = get_maximum(rank_of_berry) - (6 - ((prime_month - current_month).abs - 6).abs) * 75
  value < 0 ? 0 : value
end

def get_maximum(rank)
  if rank == :common
    200
  elsif rank == :uncommon
    300
  elsif rank == :rare
    400
  else
    500
  end
end
