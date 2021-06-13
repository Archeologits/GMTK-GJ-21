extends Furniture
class_name BluePulley

# Member variables
export (String) var chute_message : String = "Chute is open"
export (String) var passage_message : String = "Chute passage is open"

onready var other_pulley := get_node("../../GreenRoom/GreenPulley")

func interact(body : Player) -> void:
  if body.tools.has("Recipe") and !item_collected:
    Util.swap_message(collected)
    body.tools.erase("Frozen bread with butter knife")
    body.collect_tool("Burnt bread")
    body.collect_tool("Butter knife")
    item_collected = true
    $Sprite.play("break")
    # If audio added - simply uncomment the following
#    $Audio.play()
  else:
    Util.shake()
    Util.swap_message("I have nothing to microwave")
