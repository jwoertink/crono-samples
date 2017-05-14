class MonsterSelectScreen
  def initialize(@window : Window)
    @background = Crono::Image.new(asset_path("monster-select-bg.png"), {@window.width, @window.height})
    @monsters = [] of Monster
    @colors = %w(blue green yellow)
    x = 81
    @selector = OptionSelector.new(@window, x, 270, {"value" => 3, "arrow" => "down"})
    @colors.each do |color|
      @monsters << Monster.new(@window, x, 400, color)
      x += 213
    end
  end

  def draw
    @window.brush.draw(@background, {0, 0})
    @selector.draw
    @monsters.map(&.draw)
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
    end
  end
end

