class Part
  @x : Int32
  @y : Int32

  def initialize(@field : Field)
    parts, color = Parts[rand(Parts.size)]
    height = parts.lines.size
    count = parts.split.size / height
    @states = Array(Matrix).new(count) { [] of Array(SF::Color?) }
    parts.split.each_with_index do |part, i|
      @states[i % count].push part.chars.map { |c| color if c == '#'}
    end

    @state = 0
    @x = (@field.width - width) / 2

    @y = -height
    while collides? == :invalid
      @y += 1
    end
  end

  getter x
  getter y

  def body
    @states[@state]
  end
  def width
    body[0].size
  end
  def height
    body.size
  end

  def each_with_pos
    body.each_with_index do |line, y|
      line.each_with_index do |b, x|
        next unless b
        yield b, SF.vector2(@x + x, @y + y)
      end
    end
  end

  def collides?
    each_with_pos do |b, p|
      return :invalid if p.x < 0 || p.x >= @field.width || p.y < 0
    end
    each_with_pos do |b, p|
      return :collides if p.y >= @field.height || @field[p]
    end
    false
  end

  def [](p)
    x, y = p
    body[y][x]
  end

  def left
    @x -= 1
    right if out = collides?
    out
  end
  def right
    @x += 1
    left if out = collides?
    out
  end

  def down
    @y += 1
    @y -= 1 if out = collides?
    out
  end
  def cw
    @state = (@state + 1) % @states.size
    ccw if out = collides?
    out
  end
  def ccw
    @state = (@state - 1) % @states.size
    cw if out = collides?
    out
  end

  def draw(target, states)
    rect = BlockShape.new({1, 1})
    each_with_pos do |b, p|
      rect.fill_color = b
      rect.position = p
      target.draw(rect, states)
    end
  end
end

