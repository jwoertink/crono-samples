class MonsterSelectScreen
  def initialize(@window : Window)
    @background = Crono::Image.new(asset_path("monster-select-bg.png"), {@window.width, @window.height})
    @monsters = [] of Monster
    @colors = %w(blue green yellow)
    x = ((@window.width / @colors.size) - 50) / 2
    @selector = OptionSelector.new(@window, x - 20, 270, {"value" => @colors.size, "arrow" => "down"})
    @colors.each do |color|
      @monsters << Monster.new(@window, x, 400, color)
      x += (@window.width / @colors.size)
    end
    @select_song = Crono::Song.new(asset_path("select-screen.ogg"))
    @select_song.play
  end

  def draw
    @window.brush.draw(@background, {0, 0})
    @selector.draw
    @monsters.map(&.draw(0, 0))
  end

  def key_down(key)
    case key
    when .left?
      @selector.move_left
    when .right?
      @selector.move_right
    when .return?
      @window.monster = Monster.new(@window, 400, 100, @colors[@selector.value - 1])
      @window.game_in_progress = true
      @select_song.stop
      @window.game_song.play
    end
  end
end

