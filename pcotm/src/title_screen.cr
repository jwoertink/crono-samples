class TitleScreen
  getter window

  def initialize(@window : Window)
    @background = Crono::Image.new(asset_path("title-screen.png"), {@window.width, @window.height})
    @screen_text = Crono::Font.new(asset_path("PressStart2P-Regular.ttf"), 28)
    @selector = OptionSelector.new(@window, 130, 280, {"value" => 3})
  end

  def draw
    @window.brush.draw(@background, {0, 0})
    @screen_text.text = "LET'S DO THIS!"
    @screen_text.color = Crono::Color::WHITE
    @window.brush.draw(@screen_text, {210, 280})
    @screen_text.text = "ABOUT #PCOTM"
    @window.brush.draw(@screen_text, {210, 330})
    @screen_text.text = "I'M DONE"
    @window.brush.draw(@screen_text, {210, 380})
    @selector.draw
  end

  def key_down(key)
    case key
    when .up?
      @selector.move_up
    when .down?
      @selector.move_down
    when .return?
      case @selector.value
      when 1
        screen = MonsterSelectScreen.new(@window)
        @window.goto(screen)
      when 2
        screen = InfoScreen.new(@window)
        @window.goto(screen)
      when 3
        @window.close
      end
    end
  end
end

