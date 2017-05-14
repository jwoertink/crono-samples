class Monster
  @standing : Crono::Image
  property x, y

  def initialize(@window : Window, @x : Int32, @y : Int32, color : String)
    @dir = :left
    @vy = 0
    @standing = Crono::Image.new(asset_path("monster_#{color}_standing.png"), {50, 50})
    @walk_left = Crono::Image.new(asset_path("monster_#{color}_walk_left.png"), {50, 50})
    @walk_right = Crono::Image.new(asset_path("monster_#{color}_walk_right.png"), {50, 50})
    @jump = Crono::Image.new(asset_path("monster_#{color}_jump.png"), {50, 50})
    @cur_image = @standing
    @start_position = 49
  end

  def draw
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    #puts "drawing #{@x} #{@y}"
    #@x = @x + offs_x
    #@y = @y -  49 #@start_position

    @window.brush.draw(@cur_image, {@x, @y})
  end

  def fall
    #@start_position -= 1
  end

  def collision?
    # need to know where I'm at relative to the scene
    #@window.has_object_at?(@x, @y)
  end

  def key_down(key)
    case key
    when .left?
      @x -= 5
      @cur_image = @walk_left
    when .right?
      @x += 5
      @cur_image = @walk_right
    end
  end
end

