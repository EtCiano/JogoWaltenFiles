extends TextureRect

@export var centro_luz := Vector2(0.9, 0.2)
@export var raio_luz := 0.3
@export var suavidade := 0.387

func _ready() -> void:
	var mat := $Escuro.material as ShaderMaterial
	mat.set_shader_parameter("centro", centro_luz)
	mat.set_shader_parameter("raio", raio_luz)
	mat.set_shader_parameter("suavidade", suavidade)

func checarBon() -> void:
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
