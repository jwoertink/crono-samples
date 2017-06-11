class Star
  getter x, y
  getter color : Crono::Color::RGB
  property image : Crono::Image::Tiles

  def initialize
    img_path = File.join(__DIR__, "assets", "images", "star.png")
    @image = Crono::Image.load_tiles(img_path, {25, 25})
    @x = rand(640).as(Int32)
    @y = rand(480).as(Int32)
    @color = Crono::Color.rand
    @image.map {|s| s[:image].color_mod = @color}
  end
end

