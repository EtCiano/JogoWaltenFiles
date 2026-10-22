extends Timer

signal mudarBateriaLabel()

const tempoBateria = 1
const gastoPorcentagem = tempoBateria / 19.2

# 19.2s 	   -> -1%
# tempoBateria -> gastoPorcentagem

func _ready() -> void:
	print("gasto por porcentagem: ", gastoPorcentagem)

func iniciar() -> void:
	start(tempoBateria)

func _on_timeout() -> void:
	#if contagem >= 4:
		#contagem = 0
	#else:
		#contagem += 1
	#if contagem >= Global.gastoBateria:
	Global.bateriaAtual -= Global.gastoBateria * gastoPorcentagem
	mudarBateriaLabel.emit()
	#print("timer bateria: ", contagem)
	print("bateria: ", Global.bateriaAtual)
	if Global.bateriaAtual <= 0:
		Global.matarJogadorBateria()
		return
	else:
		iniciar()
