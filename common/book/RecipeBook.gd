extends Area2D
class_name RecipeBook

# Member variables
export (String) var message : String = "Press 'E' to interact"

var last_player : Player

func interact(body : Player) -> void:
  pass
  # Push book down hole (move book to Blue Room Pantry)
  
func _on_player_entered(body : Node2D) -> void:
  if body.is_in_group("Players"):
    Util.push_message(message)
    body.interactible = self
    last_player = body

func _on_player_exited(body : Node2D) -> void:
  if body == last_player:
    Util.pop_message()
    body.interactible = null
