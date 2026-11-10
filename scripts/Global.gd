extends Node

signal bonMudarCamera()
signal mudarUsoBateria()
signal eventoEnergiaSignal()
signal eventoEnergiaAcabouSignal()

enum EVENTO_BON {
	nada,
	audio,
	energia,
	desenho
}

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
	1: preload("res://scenes/cameras/camera_1.tscn"),
	2: preload("res://scenes/cameras/camera_2.tscn"),
	3: preload("res://scenes/cameras/camera_3.tscn"),
	4: preload("res://scenes/cameras/camera_4.tscn"),
	5: preload("res://scenes/cameras/camera_5.tscn"),
	6: preload("res://scenes/cameras/camera_6.tscn"),
	7: preload("res://scenes/cameras/camera_7.tscn"),
	8: preload("res://scenes/cameras/camera_8.tscn")
}

var audios: Array[AudioStream]

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
var bateriaAtual: float = 100.0
var gastoBateria = 1

var posicaoBon = 8
var posicaoAnteriorBon = 8

var continuar = false

var cameraAberta = false

var piscandoLuzes = false


func _ready() -> void:
	var caminho_pasta = "res://resources/AudiosBon/"
	if not caminho_pasta.ends_with("/"):
		caminho_pasta += "/"
		
	var dir = DirAccess.open(caminho_pasta)
	
	if dir:
		dir.list_dir_begin()
		var nome_arquivo = dir.get_next()
		
		while nome_arquivo != "":
			if not dir.current_is_dir():
				if nome_arquivo.ends_with(".mp3"):
					var caminho_completo = caminho_pasta + nome_arquivo
					var audio_carregado = load(caminho_completo)
					
					if audio_carregado:
						audios.append(audio_carregado)
						
			nome_arquivo = dir.get_next()
		dir.list_dir_end()

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

func mudarGasto(valor: int) -> void:
	gastoBateria += valor
	mudarUsoBateria.emit()

func andarBon() -> void:
	var possiveisLocais = locais[posicaoBon].duplicate(true)
	var possiveisPesos = locaisPesos[posicaoBon].duplicate(true)
	var indexAnterior: int
	if posicaoAnteriorBon in possiveisLocais:
		indexAnterior = possiveisLocais.find(posicaoAnteriorBon)
		if possiveisLocais.size() > 1:
			possiveisLocais.remove_at(indexAnterior)
			possiveisPesos.remove_at(indexAnterior)
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
	get_tree().change_scene_to_file("res://scenes/sala_seguranca.tscn")
	mostrarPosBon()
	continuar = true
	
	TimerNoite.horasPassadas = 0
	TimerNoite.iniciar()
	
	TimerTurnos.quantTurnos = 0
	TimerTurnos.iniciar()
	
	bateriaAtual = 100
	TimerBateria.iniciar()

func mostrarPosBon() -> void:
	print("bon -> ", posicaoBon)
	print("cameraAtual ->", cameraAtual)
	
func mudarPosBon(novaPos) -> void:
	posicaoAnteriorBon = 0+posicaoBon
	posicaoBon = novaPos
	mostrarPosBon()
	bonMudarCamera.emit()

func matarJogadorBateria() -> void:
	matarJogador() # temporariamente

func executarEvento(evento : EVENTO_BON) -> void:
	if evento == EVENTO_BON.audio:
		AudioLoader.stream = audios.pick_random()
		AudioLoader.play()
	if evento == EVENTO_BON.energia:
		eventoEnergiaSignal.emit()

func matarJogador() -> void:
	continuar = false
	get_tree().change_scene_to_file("res://scenes/tela_morte.tscn")
	
func _eventoEnergiaAcabou() -> void:
	eventoEnergiaAcabouSignal.emit()
