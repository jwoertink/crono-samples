require "crsfml"
require "crsfml/audio/audio"
require "./src/*"

SCALE = 2
FONT = SF::Font.from_file("src/assets/fonts/PressStart2P-Regular.ttf")

class GameScreen
  include SF::Drawable

  def initialize(@window : SF::RenderWindow)
    # Setup background
    background_texture = SF::Texture.from_file("src/assets/images/background.png")
    background_texture.repeated = false
    @background = SF::RectangleShape.new(@window.size)
    @background.scale = SF.vector2(SCALE, SCALE)
    @background.texture = background_texture
    @background.texture_rect = SF.int_rect(0, 0, @window.size.x, @window.size.y)
    @current_level = 1
    GAME.map = Map.new(@window, @current_level)
    GAME.player.position = {400, 100}

    @song = SF::Music.from_file("src/assets/audio/game-song.ogg")
    @song.loop = true
    @song.play
  end

  def key_press(event)
    GAME.player.key_press(event)
  end

  def draw(target, states)
    target.draw(@background, states)
    target.draw(GAME.map, states)
    target.draw(GAME.player, states)
  end
end

class Game
  property window : SF::RenderWindow
  property current_screen : TitleScreen | InfoScreen | MonsterSelectScreen | GameScreen
  property player : Monster
  property map : Map
  property in_progress : Bool

  def initialize
    @window = SF::RenderWindow.new(
      SF::VideoMode.new(640 * SCALE, 480 * SCALE), "Phone case of the monster"
    )
    @window.vertical_sync_enabled = true
    @current_screen = TitleScreen.new(@window)
    @player = uninitialized(Monster)
    @map = uninitialized(Map)
    @in_progress = false
  end

  def in_progress?
    @in_progress
  end

  def play
    while @window.open?
      while event = @window.poll_event
        if event.is_a?(SF::Event::Closed) ||\
        (event.is_a?(SF::Event::KeyPressed) && event.code.escape?)
          @window.close
        elsif event.is_a? SF::Event::KeyPressed
          @current_screen.key_press(event)
        end
      end

      @window.clear SF::Color::Black
      @window.draw(@current_screen)
      @window.display
    end

  end

  def goto(screen)
    @current_screen = screen 
  end
end

GAME = Game.new
GAME.play
