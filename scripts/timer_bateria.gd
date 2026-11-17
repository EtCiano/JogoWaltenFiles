extends Timer

signal mudarBateriaLabel()

# tempo da noite em fnaf = 86 (em 6 horas, são 516)
# tempo para descer 1% em fnaf = 9,6 (nos 516s de jogo, caiem 53,75% de bateria minima)
const tempoNoiteFnaf = 86.0
const porcentagemAlvo = 60.0
const tempoUmPorcentoAlvo = (86*6)/(100-porcentagemAlvo)

const tempoBateria = 1 # 19.2
const tempoUmPorcento = ((tempoUmPorcentoAlvo*TimerNoite.intervalo)/tempoNoiteFnaf)
const gastoPorcentagem = tempoBateria / tempoUmPorcento
const bateriaFinalMinima = 100-((TimerNoite.intervalo*6)/tempoUmPorcento)

# 19.2s 	   -> -1%
# tempoBateria -> gastoPorcentagem

func _ready() -> void:
	print("gasto por porcentagem: ", gastoPorcentagem)
	print("tempo a cada 1%: ", tempoUmPorcento)
	print("tempo a cada 1% Alvo: ", tempoUmPorcentoAlvo)
	print("bateria final minima: ", bateriaFinalMinima)
	print("bateria final minima Alvo: ", porcentagemAlvo)

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
	#print("bateria: ", Global.bateriaAtual)
	if Global.bateriaAtual <= 0:
		Global.bateriaAcabar.emit()
		return
	else:
		iniciar()
