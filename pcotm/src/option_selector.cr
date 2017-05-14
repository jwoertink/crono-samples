class OptionSelector
  getter value
  @total_selections : Int32

  def initialize(@window : Window, @x : Int32, @y : Int32, options = {} of String => Whatever)
    @value = 1
    @total_selections = (options["value"]? || 1).to_i
    direction = options["arrow"]? || "right"
    arrow_size = direction == "right" ? {77, 45} : {45, 77}
    @arrow = Crono::Image.new(asset_path("arrow-#{direction}.png"), arrow_size)
  end

  def draw
    @window.brush.draw(@arrow, {@x, @y})
  end

  # Move up to the next option unless the value is 0
  def move_up
    unless @value == 1
      @y -= 50
      @value -= 1
    end
  end

  # Move down to the next option unless the value is the last possible option
  def move_down
    if @value < @total_selections
      @y += 50
      @value += 1
    end
  end


  def move_left
    unless @value == 1
      @x -= 213
      @value -= 1
    end
  end

  def move_right
    if @value < @total_selections
      @x += 213
      @value += 1
    end
  end
end

