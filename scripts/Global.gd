extends Node

signal bonMudarCamera()

enum ESTADO {
	aberto,
	fechado
}

enum LADO {
	esquerda = -1,
	direita = -2
}

const locais = {
	1: [2, 7, 3],
	2: [8, 5, 1],
	3: [1],
	4: [7],
	5: [2, 6],
	6: [5, LADO.esquerda],
	7: [1, 4, LADO.direita],
	8: [-3, 2],
	LADO.esquerda: [6],
	LADO.direita: [7],
	-3: [8],
	-4: [-4]
}


const locaisPesos = {
	1: [2, 3, 1],
	2: [1, 2, 2],
	3: [1],
	4: [1],
	5: [1, 2],
	6: [1, 2],
	7: [1, 1, 2],
	8: [1, 3],
	LADO.esquerda: [1],
	LADO.direita: [1],
	-3: [1],
	-4: [1]
}

var portasAbertas = {
	LADO.esquerda: ESTADO.aberto,
	LADO.direita: ESTADO.aberto
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
var posicaoAnteriorBon = 8

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
	print(posicaoAnteriorBon, " pos anterior")
	var possiveisLocais = locais[posicaoBon].duplicate(true)
	print(possiveisLocais, " locais antes")
	var possiveisPesos = locaisPesos[posicaoBon].duplicate(true)
	print(possiveisPesos, " pesos antes")
	var indexAnterior: int
	if posicaoAnteriorBon in possiveisLocais:
		indexAnterior = possiveisLocais.find(posicaoAnteriorBon)
		if possiveisLocais.size() > 1:
			possiveisLocais.remove_at(indexAnterior)
			possiveisPesos.remove_at(indexAnterior)
	print(possiveisLocais, " locais depois")
	print(possiveisPesos, " pesos depois")
	if posicaoBon == LADO.esquerda or posicaoBon == LADO.direita:
		matarBon()
		return
	mudarPosBon(escolher_ponderado(possiveisLocais, possiveisPesos))
	
func matarBon() -> void:
	if portasAbertas[posicaoBon] == ESTADO.aberto:
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
	posicaoAnteriorBon = 0+posicaoBon
	posicaoBon = novaPos
	mostrarPosBon()
	bonMudarCamera.emit()
