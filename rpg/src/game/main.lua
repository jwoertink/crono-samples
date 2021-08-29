-- Main game

function draw()
  crono.debug("Calling Draw from LUA")
  crono.set_color("red")
  crono.draw_rect(256, 192, 512, 284)
end

function update()
  crono.debug("Calling Update from LUA")
end
