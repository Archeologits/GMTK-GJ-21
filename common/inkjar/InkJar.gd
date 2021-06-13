extends Furniture
class_name InkJar

func interact(body : Player) -> void:
  if body.tools.has("Quill") and !item_collected:
    Util.swap_message(collected)
    item_collected = true
    # If audio added - simply uncomment the following
#    $Audio.play()
  else:
    Util.shake()
