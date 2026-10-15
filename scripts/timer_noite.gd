extends Timer

const intervalo = 86 # fnaf real dura isso n sei pq
var horasPassadas = 0
const horaFinal = 6

func iniciar() -> void:
	print(horasPassadas, " AM")
	if horasPassadas == horaFinal:
		TimerTurnos.continuar = false
		if !TimerTurnos.is_stopped():
			TimerTurnos.stop()
		return
	start(intervalo)
	
func _ready() -> void:
	iniciar()

func _on_timeout() -> void:
	horasPassadas += 1
	iniciar()


func _on_timer_porta_timeout() -> void:
	pass # Matar a pietra
