extends Control

func _on_fechar_camera_pressed() -> void:
	Global.mudarGasto(-1)
	get_tree().change_scene_to_file("res://scenes/sala_seguranca.tscn")

func _ready() -> void:
	#$HorarioBateria.position += Vector2(50, 25)
	Global.bonMudarCamera.connect(_mudar_camera_bon)
	$LabelCamera.text = str(Global.cameraAtual)
	_on_camera_pressed(Global.cameraAtual)
	_mudar_camera_bon()

func _on_camera_pressed(camera: int) -> void:
	Global.cameraAtual = camera
	for cameraAntiga in $espacoCamera.get_children():
		cameraAntiga.queue_free()
	var cameraNova = Global.cameras[camera].instantiate()
	$espacoCamera.add_child(cameraNova)
	cameraNova.checarBon()
	
	$LabelCamera.text = str(camera)
		
func _mudar_camera_bon() -> void:
	for camera in $espacoCamera.get_children():
		camera.checarBon()
