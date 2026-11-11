extends Timer

signal eventoAcabou()

const tempoMax = 0.5
const tempoMin = 0

const quantPiscadas = 20

var on: bool = true
var count: int = 0

var luzes: Node2D

func _ready() -> void:
	Global.eventoEnergiaSignal.connect(_iniciar)
	eventoAcabou.connect(Global._eventoEnergiaAcabou)
	#_iniciar()

func iniciarTimer() -> void:
	start(randf_range(tempoMin, tempoMax))
	print(time_left)

func _iniciar() -> void:
	Global.piscandoLuzes = true
	
	for cameraAntiga in get_node("../../CameraLayer/camera/espacoCamera").get_children():
		cameraAntiga.queue_free()
	
	luzes = get_node("../../Luzes")
	randomize()
	iniciarTimer()

func _on_timeout() -> void:
	on = !on
	luzes.visible = on
	#get_node("../../UI/lanterna").visible = on
	count += 1
	if count >= quantPiscadas:
		Global.bateriaAtual -= 2.5
		Global.piscandoLuzes = false
		luzes.visible = true
		eventoAcabou.emit()
		return
	else:
		iniciarTimer()
