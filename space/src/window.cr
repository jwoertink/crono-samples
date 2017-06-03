class Window < Crono::Window
  @player : Player?
  @background_image : Crono::Image?

  def initialize
    initialize(640, 480)
    @stars = [] of Star
  end

  def after_init
    img_path = File.join(__DIR__, "assets", "images", "space.png")
    @background_image = Crono::Image.new(img_path, {640, 480})
    @player = Player.new
    player.warp(320, 240)
  end

  def player
    @player.not_nil!
  end

  # The order of drawing is the z-index 
  def draw
    brush.draw(@background_image.not_nil!, {0, 0})
    @stars.each { |star| brush.draw(star.image, {star.x, star.y}) }
    brush.draw(player.image, {player.x, player.y}, player.angle)
    #@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def update
    player.move
    player.collect_stars(@stars)
    if rand(100) < 4 && @stars.size < 25
      @stars.push(Star.new)
    end
    puts player.score
  end

  def key_pressed(key)
    if key.left?
      player.turn_left
    end
    if key.right?
      player.turn_right
    end
    if key.up?
      player.accelerate
    end
  end

  def key_down(key)
    if key.escape?
      close
      return
    end
  end
end
