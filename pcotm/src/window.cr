class Window < Crono::Window
  property map : Map?
  property current_level : Int32
  property monster : Monster?
  property game_in_progress : Bool
  @current_screen : TitleScreen | InfoScreen | MonsterSelectScreen | Nil
  @background : Crono::Image?
  @game_objects : Array(GameObject)

  def initialize
    initialize(640, 480)
    @current_level = 1
    @cursor_active = false
    @game_in_progress = false
    @camera_x = @camera_y = 0
    @current_screen = nil
    @map = nil
    @monster = nil
    @background = nil
    @game_objects = [] of GameObject
  end

  def after_init
    @background = Crono::Image.new(asset_path("background.png"), {800, 600})
    @current_screen = TitleScreen.new(self)
    @map = Map.new(self, current_level)
  end

  def draw
    if @game_in_progress
      brush.draw(@background.not_nil!, {0, 0})
      map.not_nil!.draw
      monster.not_nil!.draw
    else
      current_screen.draw
    end
  end

  def update
    if @game_in_progress
      monster.not_nil!.fall unless map.not_nil!.solid?(monster.not_nil!.x.to_i, monster.not_nil!.y.to_i)
    end
  end

  def key_down(key)
    if key.escape?
      close
      return
    end
    if @game_in_progress
      monster.not_nil!.key_down(key)
    else
      current_screen.key_down(key)
    end
  end

  def goto(screen)
    @current_screen = screen
  end

  def has_object_at?(x : Int32, y : Int32)
    
  end

  private def current_screen
    @current_screen.not_nil!
  end

end

