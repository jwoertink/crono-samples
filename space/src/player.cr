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
    @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 8.0
  end
  
  def turn_right
    @angle += 8.0
  end
  
  def accelerate
    @vel_x += Crono.offset_x(@angle, 1.5)
    @vel_y += Crono.offset_y(@angle, 1.5)
  end
  
  def move
    @x += @vel_x.to_i32
    @y += @vel_y.to_i32
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.75
    @vel_y *= 0.75
  end

  def collect_stars(stars : Array(Star))
    stars.reject! do |star|
      if Crono.distance(@x.to_f, @y.to_f, star.x.to_f, star.y.to_f) < 35
        @score += 10
        #@beep.play
        true
      else
        false
      end
    end
  end
end

