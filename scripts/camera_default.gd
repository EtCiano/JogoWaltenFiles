extends TextureRect

func checarBon() -> void:
	if Global.cameraAtual == Global.posicaoBon:
		$BonSprite.visible = true
	else:
		$BonSprite.visible = false
