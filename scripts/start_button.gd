extends Button

func _on_quit_button_pressed() -> void:
	pass # sair do game

func _on_start_button_pressed() -> void:
	Global.iniciar_jogo()
	get_tree().change_scene_to_file("res://scenes/sala_seguranca.tscn")
