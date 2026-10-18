extends Label

func _ready() -> void:
	self.position += Vector2(50, 25)
	
	if TimerNoite.horasPassadas == 0:
		self.text = "12 AM"
	else:
		self.text = str(TimerNoite.horasPassadas) + " AM"
	TimerNoite.mudarHorarioLabel.connect(_mudar_horario_label)

func _mudar_horario_label() -> void:
	self.text = str(TimerNoite.horasPassadas) + " AM"
