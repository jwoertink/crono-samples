class Map
  include SF::Drawable

  def initialize(@window : SF::RenderWindow, @level : Int32)
    lines = File.read_lines("src/assets/maps/level_#{@level}.txt").map(&.chomp)
    @height = lines.size.as(Int32)
    @width = lines[0].size.as(Int32)
   
    @tiles = [] of Tile
    @phones = [] of Phone
    @height.times do |y|
      @width.times do |x|
        case lines[y][x, 1]
        when "\""
          @tiles.push Tile.new("grass", {x*120 - 10, y*120 - 10})
        when "#"
          @tiles.push Tile.new("dirt", {x*120 - 10, y*120 - 10})
        when "x"
          @phones.push Phone.new("phone_#{rand(14) + 1}.png", {x * 82 + 41, y * 150 + 75})
        end
      end
    end

  end

  def draw(target, states)
    @tiles.map {|t| target.draw(t.sprite, states) }
    @phones.map {|p| target.draw(p.sprite, states) }
  end

  def solid?(x, y)
    y < 0 || @tiles.any? {|tile| tile.at?(x / 50, y / 50) }
  end
end

