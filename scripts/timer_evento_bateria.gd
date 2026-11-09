extends Timer

const tempoMax = 0.5
const tempoMin = 0

const quantPiscadas = 20

var on: bool = true
var count: int = 0

var modulate: CanvasModulate

func _ready() -> void:
	Global.eventoBateriaSignal.connect(_iniciar)
	#_iniciar()

func iniciarTimer() -> void:
	start(randf_range(tempoMin, tempoMax))
	print(time_left)

func _iniciar() -> void:
	Global.piscandoLuzes = true
	modulate = get_node("..")
	randomize()
	iniciarTimer()

func _on_timeout() -> void:
	on = !on
	modulate.visible = !on
	count += 1
	if count >= quantPiscadas:
		Global.piscandoLuzes = false
		modulate.visible = false
		return
	else:
		iniciarTimer()
