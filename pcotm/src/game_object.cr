class GameObject
  property image, x, y

  def initialize(image_name : String, x : Int32 = 0, y : Int32 = 0)
    initialize(image_name, {60, 60}, x, y)
  end

  def initialize(image_name : String, image_size : Tuple(Int32, Int32), @x : Int32, @y : Int32)
    @image = Crono::Image.new(asset_path(image_name), image_size)
  end
end

