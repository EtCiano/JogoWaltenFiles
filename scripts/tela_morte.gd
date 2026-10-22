extends VideoStreamPlayer

func _on_finished() -> void:
	self.loop = true
	self.stream = preload("res://resources/spritesBon/bonMorte2.ogv")
	self.play()
	self.finished.disconnect(_on_finished)
