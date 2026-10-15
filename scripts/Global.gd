extends Node

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

var posicaoBon = 8

func _ready() -> void:
	print("bon -> ", posicaoBon)

func andarBon() -> void:
	var possiveisLocais = locais[posicaoBon].duplicate(true)
	if posicaoBon == -1:
		if portasAbertas[posicaoBon]:
			possiveisLocais.append(-4)
	if posicaoBon == -2:
		if portasAbertas[posicaoBon]:
			possiveisLocais.append(-4)
	posicaoBon = escolher_ponderado(possiveisLocais, Array(range(possiveisLocais.size())))
	print("bon -> ", posicaoBon)
	
	
	
	
	
	
