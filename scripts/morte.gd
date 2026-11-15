extends TextureRect

func iniciar() -> void:
	var tween = create_tween()
	tween.tween_property($VBoxContainer, "modulate:a", 1, 2.5)
