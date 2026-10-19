extends Camera2D

@export var velocidade := 1000.0
var direcao := Vector2.ZERO

func ligar_botao(botao: Button, dir: Vector2) -> void:
	botao.button_down.connect(func(): direcao += dir)
	botao.button_up.connect(func(): direcao -= dir)

func _process(delta: float) -> void:
	global_position += direcao * velocidade * delta
	_limitar_posicao()

func _limitar_posicao() -> void:
	var meia_tela := get_viewport_rect().size / zoom / 2.0
	var min_x := limit_left + meia_tela.x
	var max_x := limit_right - meia_tela.x
	var min_y := limit_top + meia_tela.y
	var max_y := limit_bottom - meia_tela.y
	global_position.x = clampf(global_position.x, min_x, maxf(min_x, max_x))
	global_position.y = clampf(global_position.y, min_y, maxf(min_y, max_y))
