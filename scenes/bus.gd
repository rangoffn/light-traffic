extends CharacterBody2D
var turnright = 0
var forward = 1
var direction = 0
var stop = false # ( чтоб в друг друга не вьезжали )
var crash = 0
var speed
var cardie = false
#var previousPosition = Vector2()
var animation_names 
var random_animation_index
var car_colour = 0         #random skin on car
func _ready():
	pass

func _process(_delta):
	if Global.stopbus == true:
		stop = true
	if stop == false:
		get_node("AnimatedSprite2D").play("car5")
		if cardie == false:
			get_node("AnimatedSprite2D").play("car5")
		speed = 3 * _delta * 60 + Global.score / 1000
		if car_colour == 0:
			match direction:
				0: #вверх
					if turnright == 0:
						position.y -= speed
					if turnright == 1:
						position.x +=  speed 
				1: #слева направо
					if turnright == 0:
						position.x -= -speed
					if turnright == 1:
						position.y +=  speed 
				2: #справа налево
					if turnright == 0:
						position.x -= speed
					if turnright == 1:
						position.y +=  -speed 
				3: #вниз
					if turnright == 0:
						position.y += speed
					if turnright == 1:
						position.x +=  -speed 
		else:
			if cardie == false:
				get_node("AnimatedSprite2D").play("car5s")
	else:
		if cardie == false:
			get_node("AnimatedSprite2D").play("car5s")
	if Global.count_crash == 3:
		await get_node("AnimatedSprite2D").animation_finished
		queue_free()


func _on_detect_car_body_entered(body):# ( чтоб в друг друга не вьезжали )
	if body.is_in_group("cars") or body.is_in_group("bus"):
		stop = true
		if crash == 1:
			cardie = true
			Global.count_crash += 1
			get_node("AnimatedSprite2D").play("death")
			await get_node("AnimatedSprite2D").animation_finished
			self.queue_free()
			Global.busdead = true
func _on_detect_car_body_exited(body):#
	if body.is_in_group("cars") or body.is_in_group("bus"):
		var timer = get_tree().create_timer(0.3)  # Создаем таймер на 1 секунду
		await timer.timeout  # Ждем сигнала от таймера
		stop = false
		if crash == 1:
			cardie = true
			get_node("AnimatedSprite2D").play("death")
			await get_node("AnimatedSprite2D").animation_finished
			self.queue_free()





#чекаем на красной зоне, есть ли машины, если да, то проверяем их скорость = 0, значит пробка образовалось, loose.


#func _on_detect_car_area_entered(area):
  # Пороговое значение скорости, которое считается близким к нулю ( не готово )
#	if velocity.length() < 0.01:
#		print("Скорость близка к нулю")
#	else:
#		print("Скорость > 0")
#	previousPosition = position





#
