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
    @x = 0
    @y = 0
  end

  def jump
    if GAME.map.solid?(@x, @y + 1)  
      @vy = -20
    end
  end

  def key_press(event)
    case event.code
    when SF::Keyboard::Space, SF::Keyboard::Up
      jump  
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
      #if @vy < 0
      #  @vy.abs.times do 
      #    if would_fit?(0, -1)
      #      @y -= 1
      #    else
      #      @vy = 0
      #    end
      #  end
      #end
    end
    target.draw(@monster, states)
  end

  def would_fit?(offs_x, offs_y)
    !GAME.map.solid?(@x + offs_x, @y + offs_y) && 
    !GAME.map.solid?(@x + offs_x, @y + offs_y - 45)
  end

  def position=(point : Tuple(Int32, Int32))
    @monster.position = point
  end
end

