extends Node2D

# Member variables
var players = []

onready var popup : PopupDialog = $Popup/Popup
onready var black_screen : BlackScreen = $BlackScreen
export var ROOMS = 6
export var PLAYERS = 3
export var NUMBER_OF_SHAKES = 3
export var SHAKE_INTENSITY = 10
export var SHAKE_BREAK = 1
export var SHAKE_TIME = 0.5
var rooms_rects = []
var active_player = -1

var room : int = -1
    
func _ready():
  black_screen.unfade()
  Util.current_scene = self
  for i in range(1, PLAYERS + 1):
    players.append(get_node("Player" + str(i)))

  set_player(1)
  
  for i in range(1, ROOMS + 1):
    rooms_rects.append(get_node("Room" + str(i)).get_rect())
  popup.show() # This should be shown when doors are unlocked, etc.

func get_room(pos):
  for i in range(0, ROOMS):
    if rooms_rects[i].has_point(pos):
      return i + 1
  return -1

func set_player(i):
  for j in range(0, PLAYERS):
    players[j].current = false
  players[i - 1].current = true
  active_player = i

func set_active_player():
  for i in range(0, PLAYERS):
    if players[i].current:
      active_player = i + 1
      return

var shake_mode = false
onready var clock = 0
var shake_start = 0
var last_shake_end = 0

func _process(_delta):
  clock += _delta
  var new_room = get_room(get_node("Player" + str(active_player)).position)
  if new_room != room:
    room = new_room
    Util.show_message("Currently in Room #" + str(room))
  var rect = rooms_rects[room - 1]
  var screen_size = get_viewport().size
  var canvas_trans = get_viewport().get_canvas_transform()
  var expand_ratio = \
    min(screen_size.x / rect.size.x, \
        screen_size.y / rect.size.y)
  canvas_trans.x.x = expand_ratio
  canvas_trans.y.y = expand_ratio
  canvas_trans.origin = -rect.position * expand_ratio
  
  if shake_mode:
    if clock - shake_start <= SHAKE_TIME:
      var angle = (clock - shake_start) / SHAKE_TIME * NUMBER_OF_SHAKES * 2 * PI
      canvas_trans.origin += SHAKE_INTENSITY * sin(angle) * Vector2.RIGHT
    else:
      shake_mode = false
  get_viewport().set_canvas_transform(canvas_trans)


func screen_shake():
  if clock - shake_start > SHAKE_BREAK + SHAKE_TIME:
    shake_mode = true
    shake_start = clock
    return true
  else:
    return false
  
func _input(event : InputEvent) -> void:
  # Please don't judge this code too harshly (or refactor if deemed necessary)
  # Refactoring done -- sugar, functionality should still be the same
  if event.is_action_pressed("ui_accept"):
    Util.shake()
    return
  for i in range(1, PLAYERS + 1):
    if event.is_action_pressed("player" + str(i)):
      black_screen.fade()
      yield(black_screen.animation_player, "animation_finished")
      set_player(i)
      black_screen.unfade()
