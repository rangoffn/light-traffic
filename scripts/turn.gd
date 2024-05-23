extends Area2D



func _on_body_entered(body):
	if body.is_in_group("cars"):
		body.turnright = 1
		body.rotate(1.5708)
