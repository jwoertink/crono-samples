class Player
  property x, y, angle
  property image
  getter score

  def initialize
    img_path = File.join(__DIR__, "assets", "images", "starfighter.bmp")
    @image = Crono::Image.new(img_path, {50, 50})
    #@beep = Gosu::Sample.new("media/beep.wav")
    @x = @y = 0
    @vel_x = @vel_y = 0.0
    @angle = 0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4
  end
  
  def turn_right
    @angle += 4
  end
  
  def accelerate
    @vel_x += Crono.offset_x(@angle, 0.5)
    @vel_y += Crono.offset_y(@angle, 0.5)
  end
  
  def move
    @x += @vel_x.ceil.to_i32
    @y += @vel_y.ceil.to_i32
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def collect_stars(stars)
    #stars.reject! do |star|
      #if Gosu.distance(@x, @y, star.x, star.y) < 35
        #@score += 10
        #@beep.play
        #true
      #else
        #false
      #end
    #end
  end
end

