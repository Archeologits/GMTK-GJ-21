extends Furniture
class_name Microwave

func interact(body : Player) -> void:
  if body.tools.has("Frozen bread with butter knife") and !item_collected:
    Util.swap_message(collected)
    body.tools.erase("Frozen bread with butter knife")
    body.collect_tool("Burnt bread")
    body.collect_tool("Butter knife")
    item_collected = true
    $Sprite.hide()
    $AnimatedSprite.show()
    $AnimatedSprite.play()
    # Todo broken animation possibly


func _on_AnimatedSprite_animation_finished():
  $AnimatedSprite.stop()
  $AnimatedSprite.hide()
