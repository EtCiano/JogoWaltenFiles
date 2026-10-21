extends Timer

signal mudarBateriaLabel()

const tempoBateria = 4.8

func _ready() -> void:
	start(tempoBateria)

func _on_timeout() -> void:
	#if contagem >= 4:
		#contagem = 0
	#else:
		#contagem += 1
	#if contagem >= Global.gastoBateria:
	Global.bateriaAtual -= Global.gastoBateria * 0.25
	mudarBateriaLabel.emit()
	#print("timer bateria: ", contagem)
	print("gasto atual: ", Global.gastoBateria)
	print("bateria: ", Global.bateriaAtual)
	start(tempoBateria)
