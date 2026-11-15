extends ColorRect

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Morte, "modulate:a", 1, 2.5)
	await tween.finished
	$Morte.iniciar()
	
