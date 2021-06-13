extends KinematicBody2D
class_name Player

# Member variables
export (int, 0, 2000) var speed : int = 400
export (int, 0, 4000) var acceleration : int = 2000
export (int, 0, 100) var max_health : int = 100
export (bool) var current : bool = true

var interactible = null
var tools : Array

var facing : Vector2 = Vector2.RIGHT
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

signal interact(Player)
signal merge(Player, Player)

func collect_tool(tool_name : String) -> void:
  # If player enters tool area, tool will call this function
  print(tool_name)
  tools.push_back(tool_name)

func pass_item() -> void:
  # Possibly to pass items from one player to another if there is a gap between two rooms
  pass

func _process(_delta : float) -> void:
  if direction.length() > 1e-6:
    $Body.show()
    $StaticImage.hide()
    Sounds.play("footstep")
  else:
    $Body.hide()
    $StaticImage.show()
    
  if direction.x > 0:
    $Body.play("right")
  elif direction.x < 0:
    $Body.play("left")
  elif direction.y < 0:
    $Body.play("up")
  elif direction.y > 0:
    $Body.play("down")
  else:
    if facing.x > 0:
      $StaticImage.texture = $Body.frames.get_frame("right", 0)
    elif facing.x < 0:
      $StaticImage.texture = $Body.frames.get_frame("left", 1)      
    elif facing.y < 0:
      $StaticImage.texture = $Body.frames.get_frame("up", 0)
    elif facing.y > 0:
      $StaticImage.texture = $Body.frames.get_frame("down", 0)
  
  _handle_input()

func _physics_process(delta : float) -> void:
  _apply_movement(delta)

func _input(event) -> void:
  if current:
    if event.is_action_pressed("interact") and interactible != null:
      interactible.interact(self)

func _handle_input() -> void:
  if current:
    direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    if direction.x != 0:
      direction.y = 0
    if direction != Vector2.ZERO:
      facing = direction
      # TODO :  Write code to play the right animations!! (or use state machine)
#    if direction != Vector2.ZERO:
#      facing = direction
#      rotation = direction.angle() #_to_point(Vector2(-2*sign(direction.x), 0).normalized())
    direction = direction.normalized()

func _apply_movement(delta : float) -> void:
  velocity = velocity.move_toward(direction*speed, acceleration*delta)
  velocity = move_and_slide(velocity)


func _on_Interaction_body_entered(body : Node2D) -> void:
  if body.is_in_group("Players"):
    emit_signal("merge", self, body)
