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

  def draw
    brush.draw(@background_image.not_nil!, {0, 0})
    brush.draw(player.image, {player.x, player.y}, player.angle)
    #@stars.each { |star| star.draw }
    #@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def update
    player.move
    player.collect_stars(@stars)
    #if rand(100) < 4 && @stars.size < 25
    #  #@stars.push(Star.new(@star_anim))
    #end
  end

  def key_down(key)
    if key.escape?
      close
      return
    end
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
end
