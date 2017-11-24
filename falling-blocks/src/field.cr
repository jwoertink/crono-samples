class Field < Crono::Drawable

  def initialize(@width = 10, @height = 20)
    @clock = SF::Clock.new
    @body = Matrix.new(20) { Array(SF::Color?).new(10, nil) }
    @over = false
    @part = nil
    @interval = 1
    step
  end

  getter width
  getter height
  getter part
  property interval
  getter over

  def [](p)
    x, y = p
    @body[y][x]
  end

  def each_with_pos
    @body.each_with_index do |line, y|
      line.each_with_index do |b, x|
        next unless b
        yield b, SF.vector2(x, y)
      end
    end
  end

  def step
    @clock.restart
    if part = @part
      if part.down
        part.each_with_pos do |b, p|
          @body[p.y][p.x] = b if b
        end
        @part = nil
        lines
        step
      end
    else
      part = @part = Part.new(self)
      if part.collides?
        @over = true
      end
    end
    true
  end

  def draw(target, states)
    rect = BlockShape.new({1, 1})
    each_with_pos do |b, p|
      rect.fill_color = b
      rect.position = p
      target.draw(rect, states)
    end
    @part.try &.draw(target, states)
  end

  def lines
    @body.reject! { |line| line.all? { |b| b } }
    while @body.size < height
      @body.insert(0, Array(SF::Color?).new 10, nil)
    end
  end

  def act
    step if @clock.elapsed_time.as_seconds >= @interval
  end

  def key_press(key)
    case key
    when .left?, .a?
      part.try { |part| part.left }
    when .right?, .d?
      part.try { |part| part.right }
    when .q?
      part.try { |part| part.ccw }
    when .up?, .w?, .e?
      part.try { |part| part.cw }
    when .down?, .s?
      step
    end
  end
end
