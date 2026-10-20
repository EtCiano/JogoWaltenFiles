extends Timer

signal mudarBateriaLabel()

var contagem: int = 0

func _ready() -> void:
	start(4.8)

func _on_timeout() -> void:
	if contagem >= 4:
		contagem = 0
	else:
		contagem += 1
	if contagem >= Global.gastoBateria:
		Global.bateriaAtual -= Global.gastoBateria * 0.25
	mudarBateriaLabel.emit()
	print("timer bateria: ", contagem)
	print("bateria: ", Global.bateriaAtual)
	start(4.8)
