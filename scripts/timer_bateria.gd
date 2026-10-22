extends Timer

signal mudarBateriaLabel()

const tempoBateria = 1 # 19.2
const tempoUmPorcento = ((9.6*TimerNoite.intervalo)/86)
const gastoPorcentagem = tempoBateria / tempoUmPorcento

# 19.2s 	   -> -1%
# tempoBateria -> gastoPorcentagem

func _ready() -> void:
	print("gasto por porcentagem: ", gastoPorcentagem)
	print("tempo a cada 1%: ", tempoUmPorcento)
	print("bateria final minima: ", 100-((TimerNoite.intervalo*6)/tempoUmPorcento))

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
