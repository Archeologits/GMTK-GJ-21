extends Node2D

# Member variables
onready var camera1 : Camera2D = $Player/Camera
onready var camera2 : Camera2D = $Player2/Camera
onready var camera3 : Camera2D

onready var player1 : Player = $Player
onready var player2 : Player = $Player2
onready var player3 : Player

func _ready():
  camera1.current = true
  player1.current = true
  camera2.current = false
  player2.current = false

func _input(event : InputEvent) -> void:
  if event.is_action_pressed("player1"):
    camera1.current = true
    camera2.current = false

    player1.current = true
    player2.current = false    
  elif event.is_action_pressed("player2"):
    camera1.current = false
    camera2.current = true

    player1.current = false
    player2.current = true
  elif event.is_action_pressed("player3"):    
    pass
