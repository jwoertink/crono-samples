class Window < Crono::Window

  def initialize
    initialize(640, 480)

    @background_image = Crono::Image.new("media/space.png", {640, 480})
    @player = Player.new
    @player.warp(320.0, 240.0)

    @stars = [] of Star
  end

  def draw
    brush.draw(@background_image, {0, 0})
    @player.draw
    @stars.each { |star| star.draw }
    #@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def update

  end

  def key_down(key)
    if key.escape?
      close
      return
    end
    if key.left?
      @player.turn_left
    end
    if key.right?
      @player.turn_right
    end
    if key.up?
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)
    if rand(100) < 4 && @stars.size < 25
      #@stars.push(Star.new(@star_anim))
    end
  end
end
