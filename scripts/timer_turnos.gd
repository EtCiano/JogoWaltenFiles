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
		
		randomize()
		
		#var eventoSorteado = Global.EVENTO_BON[Global.EVENTO_BON.keys().pick_random()]
		var eventoSorteado = Global.EVENTO_BON.energia
		print("evento: ", Global.EVENTO_BON.find_key(eventoSorteado))
		if eventoSorteado != Global.EVENTO_BON.nada:
			Global.executarEvento(eventoSorteado)
		
		iniciar()
