extends Node

var current_scene = null

func show_message(text):
  current_scene.get_node("Popup/Popup/Label").text = text

func get_message() -> String:
  return current_scene.get_node("Popup/Popup/Label").text

func shake():
  current_scene.screen_shake()
