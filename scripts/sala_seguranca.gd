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
	Global.bonMudarCamera.connect(_mudar_camera_bon)
	mudarPorta(Global.LADO.esquerda, Global.portasAbertas[Global.LADO.esquerda])
	mudarPorta(Global.LADO.direita, Global.portasAbertas[Global.LADO.direita])
	$UI/HorarioBateria.position += Vector2(50, 25)
	
	$CameraLayer/camera.position.y = self.size.y
	#$CameraLayer/camera.custom_maximum_size.x = get_viewport().size.x

func _mudar_camera_bon() -> void:
	if Global.posicaoBon == Global.LADO.esquerda:
		$BonEsquerda.visible = true
		$BonDireita.visible = false
		$BonCentro.visible = false
	elif Global.posicaoBon == Global.LADO.direita:
		$BonEsquerda.visible = false
		$BonDireita.visible = true
		$BonCentro.visible = false
	elif Global.posicaoBon == -3:
		$BonEsquerda.visible = false
		$BonDireita.visible = false
		$BonCentro.visible = true
	else:
		$BonEsquerda.visible = false
		$BonDireita.visible = false
		$BonCentro.visible = false

func _on_fechar_porta(lado: Global.LADO) -> void:
	var estado_atual = Global.portasAbertas[lado]
	Global.portasAbertas[lado] = (
		Global.ESTADO.aberto if estado_atual == Global.ESTADO.fechado else Global.ESTADO.fechado
	)
	if Global.portasAbertas[lado] == Global.ESTADO.fechado:
		Global.mudarGasto(+1)
	else:
		Global.mudarGasto(-1)
	
	print('porta Dir. ', Global.portasAbertas[lado])
	
	mudarPorta(lado, Global.portasAbertas[lado])


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
	var posicaoAlvo: float
	Global.cameraAberta = !Global.cameraAberta
	if Global.cameraAberta: # tava fechado e abriu
		Global.mudarGasto(+1)
		posicaoAlvo = 0
	else:                   # tava aberto e fechou
		Global.mudarGasto(-1)
		posicaoAlvo = self.size.y
		
	var tween = create_tween()
	tween.tween_property($CameraLayer/camera, "position:y", posicaoAlvo, 0.2)
	#tween.set_trans(Tween.TransitionType.TRANS_QUAD)
	#tween.parallel().tween_property($FecharEsquerda, "modulate:a", 0.0, 10)
	#await tween.finished
	#$FecharDireita.self_modulate.a = 0
	#$FecharEsquerda.self_modulate.a = 0
