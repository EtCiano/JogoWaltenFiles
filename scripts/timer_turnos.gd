extends Timer

var tempoAcrescimo : int = 0 	# 40
const tempoTotal = 15 			# 15
const acrescimoTotal = 10 		# 10
var quantTurnos = 0

func iniciar() -> void:
	start(tempoTotal + tempoAcrescimo)
	print("turno #", quantTurnos, " Iniciado ", "(", tempoTotal + tempoAcrescimo, " = ", tempoTotal, " + ", tempoAcrescimo, ")")

func _on_timeout() -> void:
	if Global.continuar:
		quantTurnos += 1
		
		Global.andarBon()
		if Global.posicaoBon == -4:
			Global.matarJogador()
		
		tempoAcrescimo = randi_range(-acrescimoTotal, acrescimoTotal)
		iniciar()
