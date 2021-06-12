extends Area2D
class_name Candles

# Member variables
export (String) var message : String = "Press 'E' to interact"
var animation

var last_player : Player
var state : String = "off"

func _ready():
  animation = $AnimationPlayer

func interact(body : Player) -> void:
  if body.tools.has("Lighter"):
    _switch_state()

func _switch_state() -> void:
  state = "on" if state == "off" else "on"
  $Sprite.play(state)
  if state == "on":
    $Light.enabled = true
    animation.play("pulsate")
  else:
    animation.stop()
    $Light.enabled = false

func _on_player_entered(body : Node2D) -> void:
  if body.is_in_group("Players"):
    Util.push_message(message)
    body.interactible = self
    last_player = body

func _on_player_exited(body : Node2D) -> void:
  if body == last_player:
    Util.pop_message()
    body.interactible = null
