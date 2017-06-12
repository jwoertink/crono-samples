class InfoScreen
  def initialize(@window : Window)
    @background = Crono::Image.new(asset_path("info-bg.png"), {@window.width, @window.height})
    @help_text = Crono::Font.new(asset_path("PressStart2P-Regular.ttf"), 34)
    @help_text.text = "ABOUT #PCOTM"
    @help_text.color = Crono::Color[191, 32, 47] #darker red
  end

  def draw
    @window.brush.draw(@background, {0, 0})
    @window.brush.draw(@help_text, {200, 50})
  end

  def key_down(key)
    @window.goto(TitleScreen.new(@window))
  end
end

