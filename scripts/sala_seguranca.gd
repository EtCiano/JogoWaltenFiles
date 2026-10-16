extends TextureRect

func _ready() -> void:
	Global.iniciar_jogo()


func _on_fechar_esquerda_pressed() -> void:
	Global.portasAbertas[-1] = !Global.portasAbertas[-1]
	print('porta Esq. ', Global.portasAbertas[-1])


func _on_fechar_direita_pressed() -> void:
	Global.portasAbertas[-2] = !Global.portasAbertas[-2]
	print('porta Esq. ', Global.portasAbertas[-2])


func _on_timer_tutorial_timeout() -> void:
	var tween = create_tween()
	tween.tween_property($FecharDireita, "modulate:a", 0.0, 10)
	tween.parallel().tween_property($FecharEsquerda, "modulate:a", 0.0, 10)
	await tween.finished
	$FecharDireita.self_modulate.a = 0
	$FecharEsquerda.self_modulate.a = 0


func _on_abrir_camera_mouse_entered() -> void:
	pass # abrir a camerinha
