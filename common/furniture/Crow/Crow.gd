extends Furniture
class_name Crow

func interact(body : Player) -> void:
  if body.tools.has("Butter knife") and !item_collected:
    Util.swap_message(collected)
    body.collect_tool("Stuffed crow")
    item_collected = true
    $Sprite.play("break")
    # If audio added - simply uncomment the following
#    $Audio.play()
  else:
    Util.shake()
    Util.swap_message("...")

func _on_player_exited(body : Node2D) -> void:
  if interactible and body == last_player:
    Util.pop_message()
    body.interactible = null
    if item_collected:
      queue_free()
