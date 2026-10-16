extends Control

func _on_fechar_camera_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sala_seguranca.tscn")

func _ready() -> void:
	Global.bonMudarCamera.connect(_mudarCameraBon)
	$LabelCamera.text = str(Global.cameraAtual)

func _on_camera_pressed(camera: int) -> void:
	Global.cameraAtual = camera
	self.texture = Global.cameras[Global.cameraAtual]
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
	
	$LabelCamera.text = str(camera)
		
func _mudarCameraBon() -> void:
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
