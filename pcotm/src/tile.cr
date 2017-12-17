class Tile
  enum SPRITES
    Grass
    Dirt
  end
  property sprite : SF::Sprite

  def initialize(sprite_object : String, position : Tuple(Int32, Int32))
    value = SPRITES.parse(sprite_object.capitalize).to_i32 - 1
    texture = SF::Texture.from_file("src/assets/images/land-tiles.png", SF.int_rect(60*value, 0, 60, 60))
    texture.repeated = false
    @sprite = SF::Sprite.new
    @sprite.scale = SF.vector2(SCALE, SCALE)
    @sprite.texture = texture
    @sprite.position = position
  end

  #returns true if @sprite.position is at x, y
  def at?(x, y)
    @sprite.position.x == x &&
    @sprite.position.y == y
  end

end
