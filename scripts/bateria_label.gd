extends Label

func _ready() -> void:
	_mudar_bateria_label()
	TimerBateria.mudarBateriaLabel.connect(_mudar_bateria_label)

func _mudar_bateria_label() -> void:
	self.text = str(int(Global.bateriaAtual)) + " %"
