extends GarbageChute

func _ready() -> void:
  var other_chute := get_node("../../RedRoom/BedroomGarbageChute")
  other_chute.connect("chute_opened", self, "_on_chute_opened")
  connect("chute_opened", self, "_on_chute_opened")

func interact(body : Player) -> void:
  if chute_opened and !item_collected and tool_name != "":
    Util.swap_message(collected)
    body.collect_tool(tool_name)
    item_collected = true
  elif body.tools.has("Butter knife") or body.tools.has("Red key"):
    _open_chute()
