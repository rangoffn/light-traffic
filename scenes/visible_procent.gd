extends AnimatedSprite2D
 ## прозрачность светофоров
func _process(_delta):
	if animation == "green":
		modulate.a8 = 150
	else:
		modulate.a8 = 100
