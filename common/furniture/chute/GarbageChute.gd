extends Furniture
class_name GarbageChute

# Member variables
export (String) var opened : String = "Chute is open"
var chute_opened : bool = false

func interact(body : Player) -> void:
  if chute_opened and !item_collected and tool_name != "":
    Util.swap_message(collected)
    body.collect_tool(tool_name)
    item_collected = true
  elif body.tools.has("Butter knife") or body.tools.has("Red key"):
    Util.swap_message(opened)
    body.collect_tool(tool_name)
    chute_opened = true
