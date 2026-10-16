extends Node

signal bonMudarCamera()

const locais = {
	1: [2, 7, 3],
	2: [8, 5, 1],
	3: [1],
	4: [7],
	5: [2, 6],
	6: [5, -1],
	7: [1, 4, -2],
	8: [-3, 2],
	-1: [6],
	-2: [7],
	-3: [8],
	-4: [-4]
}

var portasAbertas = {
	-1: true,
	-2: true
}

const cameras = {
	1: preload("res://resources/cameras/camera1.png"),
	2: preload("res://resources/cameras/camera2.png"),
	3: preload("res://resources/cameras/camera3.png"),
	4: preload("res://resources/cameras/camera4.png"),
	5: preload("res://resources/cameras/camera5.png"),
	6: preload("res://resources/cameras/camera6.png"),
	7: preload("res://resources/cameras/camera7.png"),
	8: preload("res://resources/cameras/camera8.png")
}

const poses = {
	1: [],
	2: [],
	3: [],
	4: [],
	6: [],
	7: [],
	8: []
}

var cameraAtual = 8

var posicaoBon = 8

var continuar = false

func escolher_ponderado(itens: Array, pesos: Array) -> Variant:
	assert(itens.size() == pesos.size(), "O array de itens e o de pesos precisam ter o mesmo tamanho!")
	
	var peso_total: float = 0.0
	for peso in pesos:
		peso_total += peso
	
	var sorteio: float = randf_range(0.0, peso_total)
	
	for i in range(pesos.size()):
		sorteio -= pesos[i]
		if sorteio <= 0:
			return itens[i]
			
	return itens[-1]

func andarBon() -> void:
	var possiveisLocais = locais[posicaoBon].duplicate(true)
	if posicaoBon == -1 or posicaoBon == -2:
		matarBon()
		return
	mudarPosBon(escolher_ponderado(possiveisLocais, Array(range(possiveisLocais.size()))))
	
func matarBon() -> void:
	if portasAbertas[posicaoBon] == true:
		mudarPosBon(-4)
	else:
		mudarPosBon(8)
	
func iniciar_jogo() -> void:
	mostrarPosBon()
	continuar = true
	TimerNoite.iniciar()
	TimerTurnos.iniciar()

func mostrarPosBon() -> void:
	print("bon -> ", posicaoBon)
	
func mudarPosBon(novaPos) -> void:
	posicaoBon = novaPos
	mostrarPosBon()
	bonMudarCamera.emit()
	
