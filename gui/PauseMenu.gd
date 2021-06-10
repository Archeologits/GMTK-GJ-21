extends CanvasLayer
class_name PauseMenu

# Member variables
const SAVE_PATH = "user://saves/"
onready var animation_player : AnimationPlayer = $AnimationPlayer

var data = {"a": 2}

# Called when the node enters the scene tree for the first time.
func _ready():
  pause_mode = PAUSE_MODE_PROCESS
  animation_player.play("stop")

func _on_unload_scene(delay : float = 0.5) -> void:
  animation_player.play("fade")

func _on_scene_loaded() -> void:
  animation_player.play_backwards("fade")
  
func _input(event : InputEvent) -> void:
  if event.is_action_pressed("ui_cancel"):
    get_tree().paused = !get_tree().paused # toggle pause status
    if get_tree().paused:
      animation_player.play("fade")
    else:
      animation_player.play_backwards("fade")

func _continue() -> void:
  get_tree().paused = false
  animation_player.play_backwards("fade")  

func _new_game() -> void:
  pass

func _load_game() -> void:
  var file = File.new()
  var error = file.open_encrypted_with_pass(SAVE_PATH, File.READ, "pass")
  if error == OK:
    data = file.get_var()
    file.close()
    print(data.a)

func _save_game() -> void:
  var dir = Directory.new()
  if !dir.dir_exists(SAVE_PATH):
    dir.make_dir_recursive(SAVE_PATH)
  var file = File.new()
  var error = file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, "pass")
  if error == OK:
    file.store_var(data)
    file.close()

func _options() -> void:
  pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
