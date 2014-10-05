module SkuConfigs

  def nitrogen
    { name: :nitrogen, image_link: "nitrogen.png", window: @window,
      x: 220, y: 280, quantity: 3, height: 66, width: 60,
      description: "Gives you bonus boost for certain berries.", type: :fertilizer }
  end

  def potassium
    { name: :potassium, image_link: "potassium.png", window: @window,
      x: 260, y: 280, quantity: 3, height: 76, width: 60,
      description: "Gives you pot boost for certain berries.", type: :fertilizer }
  end

  def phosphorus
    { name: :phosphorus, image_link: "phosphorus.png", window: @window,
      x: 340, y: 280, quantity: 3, height: 76, width: 60,
      description: "Gives you pho boost for certain berries.", type: :fertilizer }
  end

  def hoe
    { name: :hoe, image_link: "hoe.png", window: @window,
      x: 375, y: 380, quantity: 1, height: 65, width: 100,
      description: "Hoe that permanently increases berry production by 1", type: :hoe }
  end

  def helpers
    { name: :helpers, image_link: "helper.png", window: @window,
      x: 410, y: 200, quantity: 3, height: 177, width: 150,
      description: "Helpers allow you to take more turns per month", type: :helper }
  end

  def tractor
    { name: :tractor, image_link: "tractor.png", window: @window,
      x: 540, y: 270, quantity: 1, height: 237, width: 350, z: 0,
      description: "The tractor lets you get more work done in less time", type: :tractor }
  end

end
