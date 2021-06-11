extends Node2D

# Member variables
onready var camera1 : Camera2D = $Player/Camera
onready var camera2 : Camera2D = $Player2/Camera
onready var camera3 : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
  camera1.current = true
  pass # Replace with function body.

func _input(event : InputEvent) -> void:
  if event.is_action_pressed("player1"):
    print("oi")
    camera1.current = true
    camera2.current = false
  elif event.is_action_pressed("player2"):
    print("oi")
    camera1.current = false
    camera2.current = true
  elif event.is_action_pressed("player3"):    
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
