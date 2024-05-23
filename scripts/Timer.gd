extends Timer
var cars = preload("res://scenes/car.tscn")

func _on_Timer_timeout():
	var car = cars.instance()
	car.position = Vector2(16, 296)
	add_child(car)
	
