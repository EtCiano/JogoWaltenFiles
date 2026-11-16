extends Button

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(get_node("../../transicao"), "modulate:a", 1, 1)
	await tween.finished
	Global.iniciar_jogo()
