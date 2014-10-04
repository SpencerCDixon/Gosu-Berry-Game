module SkuConfigs

  def nitrogen
    { name: "nitrogen", image_link: "nitrogen.png", window: @window,
      x: 80, y: 80, quantity: 1, height: 66, width: 60,
      quantity: 1, description: "Gives you bonus boost for certain berries." }
  end

  def potassium
    { name: "potassium", image_link: "potassium.png", window: @window,
      x: 180, y: 180, quantity: 1, height: 76, width: 60,
      quantity: 1, description: "Gives you bonus boost for certain berries." }
  end

  def phosphorus
    { name: "phosphorus", image_link: "phosphorus.png", window: @window,
      x: 280, y: 280, quantity: 1, height: 76, width: 60,
      quantity: 1, description: "Gives you bonus boost for certain berries." }
  end

end