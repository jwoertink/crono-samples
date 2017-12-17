class Phone 
  property sprite : SF::Sprite

  def initialize(phone_name : String, position : Tuple(Int32, Int32))
    texture = SF::Texture.from_file("src/assets/images/#{phone_name}", SF.int_rect(0, 0, 41, 74))
    texture.repeated = false
    @sprite = SF::Sprite.new
    @sprite.scale = SF.vector2(SCALE, SCALE)
    @sprite.texture = texture
    @sprite.position = position
  end
end
