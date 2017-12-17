class TitleScreen
  include SF::Drawable

  def initialize(@window : SF::RenderWindow)
    # Setup background
    background_texture = SF::Texture.from_file("src/assets/images/title-screen.png")
    background_texture.repeated = false
    @background = SF::RectangleShape.new(@window.size)
    @background.scale = SF.vector2(SCALE, SCALE)
    @background.texture = background_texture
    @background.texture_rect = SF.int_rect(0, 0, @window.size.x, @window.size.y)

    # Setup text
    @start_option = SF::Text.new("LET'S DO THIS!", FONT, 48)
    @start_option.color = SF::Color::White
    @start_option.position = {420, 560}
    @about_option = SF::Text.new("ABOUT #PCOTM", FONT, 48)
    @about_option.color = SF::Color::White
    @about_option.position = {420, 660}
    @quit_option = SF::Text.new("I'M DONE", FONT, 48)
    @quit_option.color = SF::Color::White
    @quit_option.position = {420, 760}

    @selector = OptionSelector.new(260, 540)

    @song = SF::Music.from_file("src/assets/audio/title-screen.ogg")
    @song.loop = true
    @song.play
  end

  def key_press(event)
    case event.code
    when SF::Keyboard::Return
      @song.stop
      case @selector.current_value
      when 1
        monster_select_screen = MonsterSelectScreen.new(@window)
        GAME.goto(monster_select_screen)
      when 2
        info_screen = InfoScreen.new(@window)
        GAME.goto(info_screen)
      when 3
        @window.close
      end
    else
      @selector.key_press(event)
    end
  end

  def draw(target, states)
    target.draw(@background, states)
    target.draw(@start_option, states)
    target.draw(@about_option, states)
    target.draw(@quit_option, states)
    target.draw(@selector, states)
  end
end

