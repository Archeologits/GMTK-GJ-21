extends StaticBody2D

# Member variables
export var max_candle_count : int = 4
onready var room = get_parent()

var candle_count : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  for i in range(1, max_candle_count + 1):
    var candle = room.get_node("Candle" + str(i))
    print(candle)
    candle.connect("candle_on", self, "_on_candle_on")
    candle.connect("candle_off", self, "_on_candle_off")    

func _on_candle_on() -> void:
  print("oi")
  candle_count += 1
  if candle_count == max_candle_count:
    # To Do - make sound on transition
    queue_free()

func _on_candle_off() -> void:
  candle_count -= 1
