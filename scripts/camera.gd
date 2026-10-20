extends Control

func _on_fechar_camera_pressed() -> void:
	Global.gastoBateria -= 1
	get_tree().change_scene_to_file("res://scenes/sala_seguranca.tscn")

func _ready() -> void:
	$HorarioBateria.position += Vector2(50, 25)
	Global.bonMudarCamera.connect(_mudar_camera_bon)
	$LabelCamera.text = str(Global.cameraAtual)
	_on_camera_pressed(Global.cameraAtual)
	_mudar_camera_bon()

func _on_camera_pressed(camera: int) -> void:
	Global.cameraAtual = camera
	self.texture = Global.cameras[Global.cameraAtual]
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
	
	$LabelCamera.text = str(camera)
		
func _mudar_camera_bon() -> void:
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
