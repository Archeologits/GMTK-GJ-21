extends Area2D

var red_key_sent : bool = false
var interactible : bool = true
var last_player : Player

func activate() -> void:
  pass

func interact(body : Player) -> void:
  if body.tools.has("Red key"):
    Util.swap_message("Threw red key through roof!")
    body.tools.erase("Red key")
    red_key_sent = true
  else:
    Util.shake()

func _on_player_entered(body : Node2D) -> void:
  if !red_key_sent and body.is_in_group("Players"):
    Util.push_message("Press 'E' to throw red key")
    body.interactible = self
    last_player = body

func _on_player_exited(body : Node2D) -> void:
  if interactible and body == last_player:
    Util.pop_message()
    body.interactible = null
    if red_key_sent:
      queue_free()
