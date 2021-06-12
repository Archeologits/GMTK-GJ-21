extends Node

var current_scene = null

func show_message(text):
  current_scene.get_node("Popup/Popup/Label").text = text
