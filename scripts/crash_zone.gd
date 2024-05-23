extends Area2D
func _on_body_entered(body):
	body.crash = 1



func _on_body_exited(body):
	body.crash = 0
