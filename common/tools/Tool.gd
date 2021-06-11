extends Node
class_name Tool

# Member variables
export (String) var tool_name : String = "Tool"
export (Texture) var texture : Texture

func _ready():
  connect("body_entered", self, "_on_player_entered")
  $Node2D/Sprite.texture = texture

func _on_player_entered(body : Node2D) -> void:
  if body.is_in_group("Players"):
    $Audio.play()
    body.collect_tool(tool_name)

func _on_audio_finished() -> void:
  queue_free()
