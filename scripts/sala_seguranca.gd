extends TextureRect

var portasConfig = {
	Global.LADO.esquerda: {
		Global.ESTADO.fechado: {
			"texture": preload("res://resources/portaFechada.png"),
			"flipH": false,
			"size": Vector2(336, 820),
			"position": Vector2(145, 221)
		},
		Global.ESTADO.aberto: {
			"texture": preload("res://resources/portaAberta.png"),
			"flipH": false,
			"size": Vector2(588, 1050),
			"position": Vector2(-285, 104)
		}
	},
	Global.LADO.direita: {
		Global.ESTADO.fechado: {
			"texture": preload("res://resources/portaFechada.png"),
			"flipH": true,
			"size": Vector2(336, 820),
			"position": Vector2(2384, 217)
		},
		Global.ESTADO.aberto: {
			"texture": preload("res://resources/portaAberta.png"),
			"flipH": true,
			"size": Vector2(540, 1046),
			"position": Vector2(2721, 107)
		}
	}
}

func _ready():
	$Camera2D.ligar_botao($CameraLeftButton, Vector2.LEFT)
	$Camera2D.ligar_botao($CameraRightButton, Vector2.RIGHT)
	mudarPorta(Global.LADO.esquerda, Global.portasAbertas[Global.LADO.esquerda])
	mudarPorta(Global.LADO.direita, Global.portasAbertas[Global.LADO.direita])

func _on_fechar_esquerda_pressed() -> void:
	var estado_atual = Global.portasAbertas[Global.LADO.esquerda]
	Global.portasAbertas[Global.LADO.esquerda] = (
		Global.ESTADO.aberto if estado_atual == Global.ESTADO.fechado else Global.ESTADO.fechado
	)
	print('porta Esq. ', Global.portasAbertas[Global.LADO.esquerda])
	
	mudarPorta(Global.LADO.esquerda, Global.portasAbertas[Global.LADO.esquerda])


func _on_fechar_direita_pressed() -> void:
	var estado_atual = Global.portasAbertas[Global.LADO.direita]
	Global.portasAbertas[Global.LADO.direita] = (
		Global.ESTADO.aberto if estado_atual == Global.ESTADO.fechado else Global.ESTADO.fechado
	)
	print('porta Dir. ', Global.portasAbertas[Global.LADO.direita])
	
	mudarPorta(Global.LADO.direita, Global.portasAbertas[Global.LADO.direita])


func mudarPorta(lado: Global.LADO, estado: Global.ESTADO) -> void:
	var porta: TextureRect
	
	if lado == Global.LADO.esquerda:
		porta = $portaEsq
	else:
		porta = $portaDir
	
	porta.texture = portasConfig[lado][estado]["texture"]
	porta.flip_h = portasConfig[lado][estado]["flipH"]
	porta.size = portasConfig[lado][estado]["size"]
	porta.position = portasConfig[lado][estado]["position"]


func _on_timer_tutorial_timeout() -> void:
	var tween = create_tween()
	tween.tween_property($FecharDireita, "modulate:a", 0.0, 10)
	tween.parallel().tween_property($FecharEsquerda, "modulate:a", 0.0, 10)
	await tween.finished
	$FecharDireita.self_modulate.a = 0
	$FecharEsquerda.self_modulate.a = 0


func _on_abrir_camera_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/camera.tscn")
