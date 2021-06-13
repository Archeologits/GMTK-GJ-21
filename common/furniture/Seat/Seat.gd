extends Furniture

# Member variables
var connected_to_player : bool = false
var distance_to_player : Vector2

func _physics_process(delta : float) -> void:
  if connected_to_player:
    position = last_player.position + distance_to_player

func interact(body : Player) -> void:
  # Item moves with player
  connected_to_player = !connected_to_player # toggle connection
  if connected_to_player:
    last_player = body
    distance_to_player = position - body.position
    
#  set_physics_process(true)
#  print("yes")


#func _on_player_entered(body : Node2D) -> void:
#  if !item_collected and body.is_in_group("Players"):
#    Util.push_message(message)
#    body.interactible = self
#    last_player = body
#
#func _on_player_exited(body : Node2D) -> void:
#  if interactible and body == last_player:
#    Util.pop_message()
#    body.interactible = null
#    if item_collected:
#      interactible = false
