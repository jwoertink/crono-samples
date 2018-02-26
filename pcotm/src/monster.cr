class Monster
  include SF::Drawable

  def initialize(@window : SF::RenderWindow, position, color)
    monster_texture = SF::Texture.from_file("src/assets/images/monster_#{color}.png")
    monster_texture.repeated = false
    @monster = SF::Sprite.new
    @monster.scale = SF.vector2(SCALE, SCALE)
    @monster.texture = monster_texture
    @monster.texture_rect = SF.int_rect(0, 0, 50, 50)
    @monster.position = position

    @vy = 0
    @vx = 0
    @x = 400
    @y = 100
    @position = :standing
  end

  def jump
    if GAME.map.solid?(@x, @y - 1)
      @vy = -20
    end
  end

  def move_left
    @position = :left
    @x -= 5
  end

  def move_right
    @position = :right
    @x += 5
  end

  def key_press(event)
    case event.code
    when SF::Keyboard::Space, SF::Keyboard::Up
      jump
    when SF::Keyboard::Left
      move_left
    when SF::Keyboard::Right
      move_right
    end
  end

  def draw(target, states)
    if GAME.in_progress?
      @vy += 1
      if @vy > 0
        @vy.times do 
          if would_fit?(0, 1)
            @y += 1
          else 
            @vy = 0
          end
        end
      end
      if @vy < 0
        @vy.abs.times do 
          if would_fit?(0, -1)
            @y -= 1
          else
            @vy = 0
          end
        end
      end

      #if @position == :left
      #  @vx -=5
      #end
      #if @position == :right
      #  @vx += 5
      #end
      self.position = {@x, @y}
    end
    target.draw(@monster, states)
  end

  def would_fit?(offs_x, offs_y)
    !GAME.map.solid?(@x + 100, @y + 90)# && 
    #!GAME.map.solid?(@x + 50, @y + 50 - 45)
  end

  def position=(point : Tuple(Int32, Int32))
    @monster.position = point
  end
end

