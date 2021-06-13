extends Furniture
class_name Microwave

func interact(body : Player) -> void:
  if body.tools.has("Frozen bread with butter knife") and !item_collected:
    Util.swap_message(collected)
    body.tools.erase("Frozen bread with butter knife")
    body.collect_tool("Burnt bread")
    body.collect_tool("Butter knife")
    item_collected = true
    $Sprite.play("break")
    # If audio added - simply uncomment the following
#    $Audio.play()
#    yield($Audio, "finished")
#    queue_free()
