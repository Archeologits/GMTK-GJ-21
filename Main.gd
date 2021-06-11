extends Node2D

# Member variables
onready var player1 : Player = $Player1
onready var player2 : Player = $Player2
onready var player3 : Player = $Player3

onready var camera1 : Camera2D = $Player1/Camera
onready var camera2 : Camera2D = $Player2/Camera
onready var camera3 : Camera2D = $Player3/Camera

onready var popup : PopupDialog = $Popup/Popup
onready var black_screen : BlackScreen = $BlackScreen

func _ready():
  camera1.current = true
  player1.current = true  
  camera2.current = false
  player2.current = false
  camera3.current = false
  player3.current = false
  popup.show() # This should be shown when doors are unlocked, etc.

func _input(event : InputEvent) -> void:
  # Please don't judge this code too harshly (or refactor if deemed necessary)
  if event.is_action_pressed("player1"):
    black_screen.fade()
    yield(black_screen.animation_player, "animation_finished")
    camera1.current = true
    camera2.current = false
    camera3.current = false
    player1.current = true
    player2.current = false
    player3.current = false
    black_screen.unfade()
  elif event.is_action_pressed("player2"):
    black_screen.fade()
    yield(black_screen.animation_player, "animation_finished")
    camera1.current = false
    camera2.current = true
    camera3.current = false
    player1.current = false
    player2.current = true
    player3.current = false
    black_screen.unfade()    
  elif event.is_action_pressed("player3"):
    black_screen.fade()
    yield(black_screen.animation_player, "animation_finished")
    camera1.current = false
    camera2.current = false
    camera3.current = true
    player1.current = false
    player2.current = false
    player3.current = true
    black_screen.unfade()
    
