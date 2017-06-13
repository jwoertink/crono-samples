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

  def update(move_x)
    if move_x == 0
      @cur_image = @standing
    end
    if @vy < 0
      @cur_image = @jump
    end
    if move_x > 0
      @dir = :right
      move_x.times { @x += 1 if would_fit?(20, 0) }
    end

  end

  def draw(camera_x, camera_y)
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    x = @x + offs_x + camera_x
    y = @y - 49 + camera_y
    @window.brush.draw(@cur_image, {x, y})
  end

  def key_down(key)
    case key
    when .left?
      @x -= 15
      @cur_image = @walk_left
    when .right?
      @x += 15
      @cur_image = @walk_right
    end
  end

  def would_fit?(offs_x, offs_y)
    !@window.map.not_nil!.solid?(@x + offs_x, @y + offs_y) && !@window.map.not_nil!.solid?(@x + offs_x, @y + offs_y - 45) 
  end
end

