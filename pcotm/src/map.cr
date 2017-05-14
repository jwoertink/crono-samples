class Map
  enum Tiles
    GRASS
    DIRT
  end

  property height : Int32
  property width : Int32
  @total : Int32

  def initialize(@window : Window, level : Int32)
    filename = asset_path("level_#{level}.txt")
    @tileset = [
      Tile.new("land-tiles-grass.png"),
      Tile.new("land-tiles-dirt.png")
    ]
    @phones = [] of Phone
    @tiles = [] of Int32?
    lines = File.read_lines(filename).map(&.chomp)
    @height = lines.size
    @width = lines[0].size
    @tiles = Array(Array(Int32)).new(@width) do |x|
      Array(Int32).new(@height) do |y|
        case lines[y][x, 1]
        when "\""
          Tiles::GRASS.value
        when "#"
          Tiles::DIRT.value
        when "x"
          @phones << Phone.new("phone_#{rand(14) + 1}.png", {41, 76}, x * 50 + 25, y * 50 + 25)
          3
        else
          3
        end
      end
    end
    @total = @phones.size
  end

  def draw
    height.times do |y|
      width.times do |x|
        row = @tiles[x].as(Array(Int32))
        col = row[y]
        tile = @tileset[col]?
        if tile
          tile.x = x * 45
          tile.y = y * 45
          @window.brush.draw(tile.image, {tile.x, tile.y})
        end
      end
    end
    
    @phones.map {|phone| @window.brush.draw(phone.image, {phone.x, phone.y}) }
  end

  def solid?(x, y)
    y < 0 || @tiles[x / 50].as(Array(Int32))[y / 50]
  end

end

