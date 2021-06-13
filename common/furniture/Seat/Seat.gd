extends Furniture

# Member variables
var connected_to_player : bool = false
var chair_under_crow : bool = false
var distance_to_player : Vector2

func _physics_process(delta : float) -> void:
  if connected_to_player:
    position = last_player.position + distance_to_player

func interact(body : Player) -> void:
  # Item moves with player
  connected_to_player = !connected_to_player # toggle connection
  if connected_to_player:
    $Collision.disabled = true # Disable collision -> player can "push" chair
    last_player = body
    distance_to_player = position - body.position

func _on_crow_entered(area : Area2D) -> void:
  if area.get_parent().name == "Crow":
    print("crow entered")
    chair_under_crow = true
#    $Collision.disabled = true # Disable collision -> player can "climb" chair

func _on_crow_exited(area : Area2D) -> void:
  if area.get_parent().name == "Crow":
    chair_under_crow = false
    print("crow exited")
