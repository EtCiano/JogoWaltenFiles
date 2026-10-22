extends Timer

signal mudarHorarioLabel()

#const multiplicadorHora = 1.5 # hora dura X vezes maix
const intervalo = 145
const horaFinal = 6
var horasPassadas = 0

func iniciar() -> void:
	start(intervalo)

func _on_timeout() -> void:
	horasPassadas += 1
	mudarHorarioLabel.emit()
	if horasPassadas == horaFinal:
		Global.continuar = false
		if !TimerTurnos.is_stopped():
			TimerTurnos.stop()
		get_tree().change_scene_to_file("res://scenes/tela_final.tscn")
		return

	if Global.continuar:
		print(horasPassadas, " AM")
		iniciar()
