# TODO: Write documentation for `Rpg`
module Rpg
  VERSION = "0.1.0"

  def self.boot!
    config = Crono::GameConfig.new(width: 1024, height: 768, title: "Classic RPG")
    code = Crono::GameLoader.new(path: Path["./src/game/"])
    Crono.boot(code, config)
  end
end
