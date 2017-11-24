require "crono"
require "./src/*"

alias Matrix = Array(Array(SF::Color?))

game = Window.new
game.title = "Falling Blocks"
game.show

