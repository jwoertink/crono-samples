class Star
  getter x, y
  property image

  def initialize
    img_path = File.join(__DIR__, "assets", "images", "star.png")
    @image = Crono::Image.new(img_path, {25, 25})
    @color = Crono::Color::BLACK
    #@color.red = rand(256 - 40) + 40
    #@color.green = rand(256 - 40) + 40
    #@color.blue = rand(256 - 40) + 40
    @x = rand(640).as(Int32)
    @y = rand(480).as(Int32)
  end

end

