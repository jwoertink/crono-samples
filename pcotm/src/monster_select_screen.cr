class MonsterSelectScreen 
  include SF::Drawable

  def initialize(@window : SF::RenderWindow)
    # Setup background
    background_texture = SF::Texture.from_file("src/assets/images/monster-select-screen.png")
    background_texture.repeated = false
    @background = SF::RectangleShape.new(@window.size)
    @background.scale = SF.vector2(SCALE, SCALE)
    @background.texture = background_texture
    @background.texture_rect = SF.int_rect(0, 0, @window.size.x, @window.size.y)
    @selector = OptionSelector.new(200, 520, {"arrow" => "down"})
    @monsters = [] of Monster
    @colors = {:blue, :green, :yellow}
    x = ((@window.size.x / 3) - 50) / 2.0
    @colors.each do |color|
      @monsters.push Monster.new(@window, {x, 690}, color)
      x += (@window.size.x / 3)
    end

    @song = SF::Music.from_file("src/assets/audio/select-screen.ogg")
    @song.loop = true
    @song.play
  end

  def key_press(event)
    case event.code
    when SF::Keyboard::Return
      @song.stop
      GAME.player = @monsters[@selector.current_value - 1]
      game_screen = GameScreen.new(@window)
      GAME.goto(game_screen)
    else
      @selector.key_press(event)
    end
  end

  def draw(target, states)
    target.draw(@background, states)
    target.draw(@selector, states)
    @monsters.map {|m| target.draw(m, states) }
  end
end

