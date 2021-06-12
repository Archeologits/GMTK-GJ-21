extends CanvasLayer


func _process(delta):
  var viewport = get_viewport().size
  $Popup.rect_position.x = viewport.x / 2 - $Popup.rect_size.x/2
  $Popup.rect_position.y = viewport.y - $Popup.rect_size.y * 2
