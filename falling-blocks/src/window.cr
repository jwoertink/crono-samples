class Window < Crono::Window
  property field : Field
  property states : SF::RenderStates

  def initialize
    @field = Field.new
    scale = 40
    initialize(field.width*scale, field.height*scale)
    transform = SF::Transform::Identity
    transform.scale(scale, scale)
    @states = SF::RenderStates.new(transform: transform)
  end

  def update
    field.act
    close if field.over
  end

  def draw
    drawables.add(field, states)
  end

  def key_pressed(key)
    if key.escape?
      close
      return
    else
      field.key_press(key)
    end
  end

end
