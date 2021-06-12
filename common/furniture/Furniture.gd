extends Node2D
class_name Furniture

# Member variables
export (String) var furniture_name : String = "Furniture"
export (String) var tool_name : String = "Tool"
export (String) var message : String = "Press 'E' to interact"
onready var interact : Area2D = $Interact

var broken : bool = false
var last_player : Player

func _ready() -> void:
  interact.connect("body_entered", self, "_on_player_entered")
  interact.connect("body_exited", self, "_on_player_exited")

func interact(body : Player) -> void:
  body.collect_tool(tool_name)
  broken = true

func _on_player_entered(body : Node2D) -> void:
  if body.is_in_group("Players"):
    body.interactible = self
    last_player = body
    Util.push_message(message)

func _on_player_exited(body : Node2D) -> void:
  if body == last_player:
    body.interactible = null
    Util.pop_message()
