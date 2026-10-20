extends Label

func _ready() -> void:
	if TimerNoite.horasPassadas == 0:
		self.text = "12 AM"
	else:
		self.text = str(TimerNoite.horasPassadas) + " AM"
	TimerNoite.mudarHorarioLabel.connect(_mudar_horario_label)

func _mudar_horario_label() -> void:
	self.text = str(TimerNoite.horasPassadas) + " AM"
