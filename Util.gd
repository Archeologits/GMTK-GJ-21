extends Node

var current_scene = null
var player : int
var messages : Dictionary

func set_message_stacks(player_count : int) -> void:
  for player in range(1, player_count+1):
    messages[player] = []

func push_message(text : String) -> void:
  messages[player].push_back(text)
  _update_message()

func swap_message(text : String) -> void:
  if !messages[player].empty():
    messages[player][-1] = text
    _update_message()

func pop_message() -> void:
  messages[player].pop_back()
  _update_message()

func _update_message() -> void:
  if !messages[player].empty():
    current_scene.get_node("Popup/Popup/Label").text = messages[player].back()

func shake():
  current_scene.screen_shake()
