extends CanvasLayer
class_name BlackScreen

# Member variables
onready var animation_player : AnimationPlayer = $BlackScreen/AnimationPlayer

func fade() -> void:
  animation_player.play("fade")

func unfade() -> void:
  animation_player.play_backwards("fade")
