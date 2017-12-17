class OptionSelector
  include SF::Drawable
  property current_value : Int32

  def initialize(@x : Int32, @y : Int32, config = {} of String => String | Int32)
    # set the arrow
    direction = config["arrow"]? || "right"
    @movement = direction == "right" ? :horizontal : :vertical
    arrow_texture = SF::Texture.from_file("src/assets/images/arrow-#{direction}.png")
    arrow_texture.repeated = false
    @arrow = SF::RectangleShape.new(arrow_texture.size)
    @arrow.scale = SF.vector2(SCALE, SCALE)
    @arrow.texture = arrow_texture
    @arrow.texture_rect = SF.int_rect(0, 0, arrow_texture.size.x.to_i, arrow_texture.size.y.to_i)
    @arrow.position = {@x, @y}

    @current_value = 1
    @selections = (config["options"]? || 3).as(Int32)
  end

  def key_press(event)
    case event.code
    when SF::Keyboard::Down
      move_down   if @movement == :horizontal
    when SF::Keyboard::Up
      move_up     if @movement == :horizontal
    when SF::Keyboard::Right
      move_right  if @movement == :vertical
    when SF::Keyboard::Left
      move_left   if @movement == :vertical
    end
  end

  def draw(target, states)
    target.draw(@arrow, states)
  end

  def move_down
    if @current_value < @selections
      @y += 100
      @arrow.position = {@x, @y}
      @current_value += 1
    end
  end

  def move_up
    unless @current_value == 1
      @y -= 100
      @arrow.position = {@x, @y}
      @current_value -= 1
    end
  end

  def move_right
    if @current_value < @selections
      @x += 415
      @arrow.position = {@x, @y}
      @current_value += 1
    end
  end

  def move_left
    unless @current_value == 1
      @x -= 415
      @arrow.position = {@x, @y}
      @current_value -= 1
    end
  end
end

