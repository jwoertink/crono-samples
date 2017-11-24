class BlockShape < SF::RectangleShape
  # Cache of darkened/lightened color sets
  @@colors = {} of SF::Color => Array(SF::Color)

  private def colors
    c = fill_color
    @@colors.fetch(c) do
      h, s, l = Crono::Color.rgb_to_hsl(c.r / 255.0, c.g / 255.0, c.b / 255.0)
      @@colors[c] = [-0.23, -0.07, 0.0, 0.11, -0.14].map { |d|
        rgb = Crono::Color.hsl_to_rgb(h, (s + d/2).clamp(0.0, 1.0), (l + d).clamp(0.0, 1.0))
        SF::Color.new(*rgb.map { |c| (c * 255).to_i8 }, c.a)
      }
    end
  end

  def draw(target, states)
    states.transform = (states.transform * transform).scale(size)

    back, out, ins = {0.0, 0.02, 0.18}.map { |k|
      [{k, k}, {1-k, k}, {1-k, 1-k}, {k, 1-k}]
    }
    ins.reverse!
    [
      back, out, ins, # background, sides, middle
      out[0..1] + ins[2..3], # top
      ins[0..1] + out[2..3], # bottom
    ].zip(colors) do |pts, color|
      target.draw(pts.map { |p| SF::Vertex.new(p, color) }, SF::TrianglesFan, states)
    end
  end
end

