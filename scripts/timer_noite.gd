extends Timer

signal mudarHorarioLabel()

const intervalo = 86 # fnaf real dura isso n sei pq
var horasPassadas = -1
const horaFinal = 6

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
	horasPassadas += 1
	iniciar()
	mudarHorarioLabel.emit()
