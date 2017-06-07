class Window < Crono::Window
  @player : Player?
  @background_image : Crono::Image?
  @score_text : Crono::Font

  def initialize
    initialize(640, 480)
    @stars = [] of Star
    font_path = File.join(__DIR__, "assets", "fonts", "zerovelo.ttf")
    @score_text = Crono::Font.new(font_path, 18)
    @score_text.text = "Score: 0"
    @score_text.color = Crono::Color::YELLOW
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
    @stars.each { |star| 
      brush.animate(star.image, {star.x, star.y}) 
    }
    brush.draw(player.image, {player.x, player.y}, player.angle)
    brush.draw(@score_text, {10, 10})
  end

  def update
    player.move
    player.collect_stars(@stars)
    @score_text.text = "Score: #{player.score}"
    if rand(100) < 4 && @stars.size < 25
      @stars.push(Star.new)
    end
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
