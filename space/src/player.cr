class Player
  property x, y, angle
  property image
  getter score

  def initialize
    img_path = File.join(__DIR__, "assets", "images", "starfighter.bmp")
    @image = Crono::Image.new(img_path, {50, 50})
    #@beep = Gosu::Sample.new("media/beep.wav")
    @x = @y = @vel_x = @vel_y = 0
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
    #@vel_x += Gosu.offset_x(@angle, 0.5)
    #@vel_y += Gosu.offset_y(@angle, 0.5)
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x = (@vel_x * 9.5).floor.to_i32
    @vel_y = (@vel_y * 9.5).floor.to_i32
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

