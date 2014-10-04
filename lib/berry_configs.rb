module BerryConfig

  def orange_config
    { price: 500, window: self, x: 10, y: 400, color: "orange", genetics: ["y", "y", "y", "y"], cols: 4, type: :very_rare, prime_month: 9 }
  end

  def green_config
    { price: 200, window: self, x: 10, y: 300, color: "green", genetics: ["x", "x", "y", "y"], cols: 2, type: :uncommon, prime_month: 2 }
  end

  def pink_config
    { price: 500, window: self, x: 10, y: 300, color: "pink", genetics: ["x", "x", "x", "x"], cols: 4, type: :very_rare, prime_month: 1 }
  end

  def red_config
    { price: 200, window: self, x: 10, y: 400, color: "red", genetics: ["y", "y", "z", "z"], cols: 2, type: :uncommon, prime_month: 6 }

  end

  def yellow_config
    genetics = [["x", "x", "x", "y"], ["x", "x", "x", "z"]].sample
    { price: 100, window: self, x: 10, y: 350, color: "yellow", genetics: genetics, cols: 1, type: :common, prime_month: 4, prime_sell_month: 10 }
  end

  def white_config
    genetics = [["x", "x", "x", "y"], ["x", "x", "x", "z"]].sample
    { price: 100, window: self, x: 10, y: 300, color: "white", genetics: genetics, cols: 1, type: :common, prime_month: 0, prime_sell_month: 6 }
  end

  def black_config
    genetics = [["x", "z", "z", "z"], ["y", "z", "z", "z"]].sample
    { price: 100, window: self, x: 10, y: 400, color: "black", genetics: genetics, cols: 1, type: :common, prime_month: 8, prime_sell_month: 2 }
  end

  def blue_config
    { price: 500, window: self, x: 10, y: 350, color: "blue", genetics: ["z", "z", "z", "z"], cols: 4, type: :very_rare, prime_month: 5, prime_sell_month: 11 }
  end

  def gray_config
    { price: 200, window: self, x: 10, y: 350, color: "gray", genetics: ["x", "x", "z", "z"], cols: 2, type: :uncommon, prime_month: 10, prime_sell_month: 4 }
  end

  def teal_config
    { price: 300, window: self, x: 10, y: 300, color: "teal", genetics: ["x", "x", "y", "z"], cols: 3, type: :rare, prime_month: 3, prime_sell_month: 9 }
  end

  def brown_config
    { price: 300, window: self, x: 10, y: 350, color: "brown", genetics: ["x", "y", "y", "z"], cols: 3, type: :rare, prime_month: 11, prime_sell_month: 5 }
  end

  def purple_config
    { price: 300, window: self, x: 10, y: 400, color: "purple", genetics: ["x", "y", "z", "z"], cols: 3, type: :rare, prime_month: 7, prime_sell_month: 1 }
  end

end
