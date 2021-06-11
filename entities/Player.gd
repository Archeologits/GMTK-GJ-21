extends KinematicBody2D
class_name Player

# Member variables
export (int, 0, 2000) var speed : int = 400
export (int, 0, 4000) var acceleration : int = 2000
export (int, 0, 100) var max_health : int = 100

var has_tool : bool = false

#onready var healthbar : HealthBar = $"../HUD/Health" 

var facing : Vector2 = Vector2.RIGHT
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

func _process(delta):
  _handle_input()

func _physics_process(delta : float) -> void:
  _apply_movement(delta)

func _handle_input() -> void:
  direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
  direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
  if direction != Vector2.ZERO:
    facing = direction
    rotation = direction.angle() #_to_point(Vector2(-2*sign(direction.x), 0).normalized())
  direction = direction.normalized()

func _apply_movement(delta : float) -> void:
  velocity = velocity.move_toward(direction*speed, acceleration*delta)
  velocity = move_and_slide(velocity)
