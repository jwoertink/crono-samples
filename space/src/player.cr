class Player
  property x, y, angle
  property image
  getter score

  VELOCITY = 2

  def initialize
    img_path = File.join(__DIR__, "assets", "images", "starfighter.bmp")
    @image = Crono::Image.new(img_path, {50, 50})
    audio_path = File.join(__DIR__, "assets", "audio", "beep.wav")
    @beep = Crono::Sound.new(audio_path)
    @x = @y = @vel_x = @vel_y = 0
    @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4.5
    @vel_x -= VELOCITY
  end
  
  def turn_right
    @angle += 4.5
    @vel_x += VELOCITY
  end
  
  def accelerate
  end

  def key_down(key)
    if key.up?
      @vel_y -= VELOCITY
    end
  end

  def key_pressed(key)
    if key.left?
      turn_left
    end
    if key.right?
      turn_right
    end
  end

  def key_up(key)
    if key.up?
      @vel_y += VELOCITY
    end
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
  end

  def collect_stars(stars : Array(Star))
    stars.reject! do |star|
      if Crono.distance(@x.to_f, @y.to_f, star.x.to_f, star.y.to_f) < 35
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end
end

