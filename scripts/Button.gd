extends Button

var light_colour = 0

func _on_pressed():
	light_colour = (light_colour - 1)*(light_colour - 1)
	if light_colour == 0:
		get_node("AnimatedSprite2D").play("green")
	else:
		get_node("AnimatedSprite2D").play("red")


func _on_area_2d_body_entered(body):
	if light_colour == 1:
		body.car_colour = 1
		await get_node("AnimatedSprite2D").animation_changed
		body.car_colour = 0
	else:
		pass
	
	
	#if body.car_colour == 1:
		#body.forward = 0
	#else:
		#body.forward = 1

func _on_area_2d_body_exited(body): # при выходе он должен получить сигнал, что он может ехать до конца, иначе 
	# он и дальше будет опираться на светофор, который уже позади него.
	#body.forward = 1
	body.car_colour = 0
