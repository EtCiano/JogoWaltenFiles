extends Timer

signal mudarHorarioLabel()

const multiplicadorHora = 2 # hora dura 2x maix
const intervalo = 86 * multiplicadorHora # fnaf real dura isso n sei pq
var horasPassadas = 0
const horaFinal = 6
var contagem = 0

func iniciar() -> void:
	if horasPassadas == horaFinal:
		Global.continuar = false
		if !TimerTurnos.is_stopped():
			TimerTurnos.stop()
		return
		
	if Global.continuar:
		print(horasPassadas, " AM")
		start(intervalo)

func _on_timeout() -> void:
	#if contagem >= 1:
	horasPassadas += 1
	mudarHorarioLabel.emit()
	iniciar()
	contagem += 1
