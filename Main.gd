extends Node2D

# Member variables
var players = []

onready var popup : PopupDialog = $Popup/Popup
onready var black_screen : BlackScreen = $BlackScreen
export var ROOMS = 6
export var PLAYERS = 3
var rooms_rects = []
var active_player = -1

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

func _process(_delta):
  var room = get_room(get_node("Player" + str(active_player)).position)
  Util.show_message("Currently in Room #" + str(room))
  var rect = rooms_rects[room - 1]
  var screen_size = get_viewport().size
  var canvas_trans = get_viewport().get_canvas_transform()
  var shrink_ratio = \
    min(screen_size.x / rect.size.x, \
        screen_size.y / rect.size.y)
  canvas_trans.x.x = shrink_ratio
  canvas_trans.y.y = shrink_ratio
  canvas_trans.origin = -rect.position * shrink_ratio
  get_viewport().set_canvas_transform(canvas_trans)
  

  
func _input(event : InputEvent) -> void:
  # Please don't judge this code too harshly (or refactor if deemed necessary)
  # Refactoring done -- sugar, functionality should still be the same
  for i in range(1, PLAYERS + 1):
    if event.is_action_pressed("player" + str(i)):
      black_screen.fade()
      yield(black_screen.animation_player, "animation_finished")
      set_player(i)
      black_screen.unfade()
