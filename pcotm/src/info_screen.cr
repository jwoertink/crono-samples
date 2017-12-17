class InfoScreen
  include SF::Drawable

  def initialize(@window : SF::RenderWindow)
    # Setup background
    background_texture = SF::Texture.from_file("src/assets/images/info-screen.png")
    background_texture.repeated = false
    @background = SF::RectangleShape.new(@window.size)
    @background.scale = SF.vector2(SCALE, SCALE)
    @background.texture = background_texture
    @background.texture_rect = SF.int_rect(0, 0, @window.size.x, @window.size.y)
  end

  def key_press(event)
    title_screen = TitleScreen.new(@window)
    GAME.goto(title_screen)
  end

  def draw(target, states)
    target.draw(@background, states)
  end
end

