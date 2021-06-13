extends Furniture
class_name BluePulley

# Member variables
onready var other_pulley := get_node("../../GreenRoom/GreenPulley")

func interact(body : Player) -> void:
  if body.tools.has("Recipe") and !item_collected:
    Util.swap_message(collected)
    body.tools.erase("Recipe")
    body.collect_tool("Red key")
    other_pulley.tool_name = "Recipe"
    item_collected = true
    # If audio added - simply uncomment the following
#    $Audio.play()
  else:
    Util.shake()
    Util.swap_message("I have nothing to send")
