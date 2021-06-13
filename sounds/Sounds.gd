extends Node

var sounds : Dictionary

var last_played = ""

func _ready():
  sounds["candle_light"] = [preload("res://sounds/effects/candle_light.wav"), 10]
  sounds["footstep"] = [preload("res://sounds/effects/footstep.wav"), 0]
  sounds["bluespark_footstep"] = [preload("res://sounds/effects/bluespark_footstep.wav"), 0]
  sounds["garbage_chute"] = [preload("res://sounds/effects/garbage_chute.wav"), 10]
  sounds["lighter_use"] = [preload("res://sounds/effects/lighter_use.wav"), 10]
  sounds["microwave_explode"] = [preload("res://sounds/effects/microwave.wav"), 10]
  sounds["weird_meal"] = [preload("res://sounds/effects/weird_meal.wav"), 10]
  pass  

func play(name):
  var audio = Util.current_scene.get_node("AudioPlayer")
  if !audio.is_playing():
    audio.stream = sounds[name][0]
    audio.play()
    last_played = name
  elif last_played != "" and sounds[name][1] > sounds[last_played][1]:
    audio.stream = sounds[name][0]
    audio.play()
    last_played = name
