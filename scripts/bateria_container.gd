extends HBoxContainer

func _ready() -> void:
	Global.mudarUsoBateria.connect(_mudar_uso_bateria)


func _mudar_uso_bateria() -> void:
	match Global.gastoBateria:
		1:
			$"1".modulate.a = 1
			$"2".modulate.a = 0
			$"3".modulate.a = 0
			$"4".modulate.a = 0
		2:
			$"1".modulate.a = 1
			$"2".modulate.a = 1
			$"3".modulate.a = 0
			$"4".modulate.a = 0
		3:
			$"1".modulate.a = 1
			$"2".modulate.a = 1
			$"3".modulate.a = 1
			$"4".modulate.a = 0
		4:
			$"1".modulate.a = 1
			$"2".modulate.a = 1
			$"3".modulate.a = 1
			$"4".modulate.a = 1
