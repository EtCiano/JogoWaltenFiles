extends Timer

var tempoAcrescimo : int = 0
const tempoTotal = 10
const acrescimoTotal = 0
var quantTurnos = 0
var continuar = true

func iniciar() -> void:
	if continuar:
		start(tempoTotal + tempoAcrescimo)
		print("turno #", quantTurnos, " Iniciado ", "(", tempoTotal + tempoAcrescimo, " = ", tempoTotal, " + ", tempoAcrescimo, ")")

func _ready() -> void:
	iniciar()

func _on_timeout() -> void:
	quantTurnos += 1
	
	Global.andarBon()
	if Global.posicaoBon == -4:
		continuar = false
	
	tempoAcrescimo = randi_range(-acrescimoTotal, acrescimoTotal)
	iniciar()
