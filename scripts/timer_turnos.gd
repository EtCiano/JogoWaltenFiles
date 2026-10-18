extends Timer

var tempoAcrescimo : int = 0 # 56 
const tempoTotal = 10 		 # 30
const acrescimoTotal = 0 	 # 10
var quantTurnos = 0

func iniciar() -> void:
	start(tempoTotal + tempoAcrescimo)
	print("turno #", quantTurnos, " Iniciado ", "(", tempoTotal + tempoAcrescimo, " = ", tempoTotal, " + ", tempoAcrescimo, ")")

func _on_timeout() -> void:
	if Global.continuar:
		quantTurnos += 1
		
		Global.andarBon()
		if Global.posicaoBon == -4:
			Global.continuar = false
		
		tempoAcrescimo = randi_range(-acrescimoTotal, acrescimoTotal)
		iniciar()


func _on_timer_porta_timeout() -> void:
	pass # Matar a pietra :X
