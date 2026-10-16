extends Timer

const intervalo = 86 # fnaf real dura isso n sei pq
var horasPassadas = 0
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


func _on_timer_porta_timeout() -> void:
	pass # Matar a pietra
