extends Node2D

var scene_to_spawn = preload("res://scenes/car.tscn")
var scene_to_spawn_bus = preload("res://scenes/bus.tscn")
var spawn_index = 0
var body_in = 0
var body_in2 = 0
var body_in3 = 0
var body_in4 = 0
var body_in5 = 0
var body_in6 = 0
var body_in7 = 0
var body_in8 = 0
var last_crash_count = -1
var timer
var alltime
var remaining_time
var target_position = Vector2(525, -175)
var object
var bus_out = false
var timeout_bus = false
var timer_1



func _ready(): 
	alltime = get_tree().create_timer(250, false)
	timer = get_tree().create_timer(115)
	randomize()
	schedule_next_spawn()
	var random_spawn_time = 1.4
	$Timer.wait_time = random_spawn_time
	$Timer.start()
	$Timer2.wait_time = 100
	$Timer2.start()

func _on_timer_2_timeout():
	object = scene_to_spawn_bus.instantiate()
	call_deferred("add_child",object)
	object.position = Vector2(-170, -1000)
	object.rotate(3.14159)
	object.direction = 3
	bus_out = true

func _on_timer_timeout():
	spawn_object(spawn_index)
	spawn_index +=1
	if spawn_index < 8:
		var random_spawn_time = 1.2
		$Timer.wait_time = random_spawn_time
		$Timer.start()
	else:
		spawn_index = 0
	
func spawn_object(index):
	var object = scene_to_spawn.instantiate()
	call_deferred("add_child",object)
	match index:
		0:
			object.position = Vector2(48, 1000)
			object.direction = 0
		1:
			object.position = Vector2(170, 1000)
			object.direction = 0
		2:
			object.position = Vector2(-1408, 170)
			object.rotate(1.5708)
			object.direction = 1
		3:
			object.position = Vector2(-1408, 48)
			object.rotate(1.5708)
			object.direction = 1
		4:
			object.position = Vector2(1408, -48)
			object.rotate(-1.5708)
			object.direction = 2
		5:
			object.position = Vector2(1408, -170)
			object.rotate(-1.5708)
			object.direction = 2
		6:
			object.position = Vector2(-48, -1000)
			object.rotate(3.14159)
			object.direction = 3
		7:
			object.position = Vector2(-170, -1000)
			object.rotate(3.14159)
			object.direction = 3
	
func schedule_next_spawn():
	var random_spawn_time = 0.7
	$Timer.wait_time = random_spawn_time
	$Timer.start()
	

func _process(delta):
	if Global.busdead == true:
		get_node("1health").play("0health")
		await get_node("1health").animation_finished
		get_node("nt").play("ntt")
	if bus_out == true:
		$stilltime.text = "Крайнее время \n прибытия: " + str(int(timer.get_time_left()))
		if timeout_bus == true:
			$stilltime.text = "Не прибыл вовремя!"
	else: $stilltime.text = " "
	$alltime.text = "still: " + str(int(alltime.get_time_left()))
	if Global.count_crash != last_crash_count:  # Проверяем, изменилось ли значение
		match Global.count_crash:
			0:
				get_node("health").play("3health")
			1:
				get_node("health").play("2health")
			2:
				get_node("2health").play("1health")
			3:
				get_node("1health").play("0health")
				await get_node("1health").animation_finished
				get_node("nt").play("ntt")
		last_crash_count = Global.count_crash
	if body_in > 5:
		get_node("nt").play("traff_line")
	if body_in4 > 5:
		get_node("nt").play("traff_line")
	if body_in2 > 5:
		get_node("nt").play("traff_line")
	if body_in3 > 5:
		get_node("nt").play("traff_line")
	if (body_in5 > 10) or (body_in6 > 10) or (body_in7 > 10) or (body_in8 > 10):
		get_node("nt").play("traff_line")
		


func _on_nt_animation_finished():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	Global.colour = 0
	Global.car_on_zone = false
	Global.score = 0
	Global.count_cars = 0
	Global.count_crash = 0
	spawn_index = 0
	body_in = 0
	body_in2 = 0
	body_in3 = 0
	body_in4 = 0
	body_in5 = 0
	body_in6 = 0
	body_in7 = 0
	body_in8 = 0
	last_crash_count = -1
	Global.stopbus = false
	Global.busdead = false



func _on_menu_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	Global.colour = 0
	Global.car_on_zone = false
	Global.score = 0
	Global.count_cars = 0
	Global.count_crash = 0
	spawn_index = 0
	body_in = 0
	body_in2 = 0
	body_in3 = 0
	body_in4 = 0
	body_in5 = 0
	body_in6 = 0
	body_in7 = 0
	body_in8 = 0
	last_crash_count = -1



func _on_dead_line_body_entered(body):
	if body.is_in_group("cars"):
		body_in +=1
func _on_dead_line_body_exited(body):
	if body.is_in_group("cars"):
		body_in -=1

func _on_dead_line_2_body_entered(body):
	if body.is_in_group("cars"):
		body_in2 +=1

func _on_dead_line_2_body_exited(body):
	if body.is_in_group("cars"):
		body_in2 -=1

func _on_dead_line_3_body_entered(body):
	if body.is_in_group("cars"):
		body_in3 +=1

func _on_dead_line_3_body_exited(body):
	if body.is_in_group("cars"):
		body_in3 -=1

func _on_dead_line_4_body_entered(body):
	if body.is_in_group("cars"):
		body_in4 +=1

func _on_dead_line_4_body_exited(body):
	if body.is_in_group("cars"):
		body_in4 -=1

func _on_dead_line_5_body_entered(body):
	if body.is_in_group("cars"):
		body_in5 -=1

func _on_dead_line_5_body_exited(body):
	if body.is_in_group("cars"):
		body_in5 -=1

func _on_dead_line_6_body_entered(body):
	if body.is_in_group("cars"):
		body_in6 +=1

func _on_dead_line_6_body_exited(body):
	if body.is_in_group("cars"):
		body_in6 -=1

func _on_dead_line_7_body_entered(body):
	if body.is_in_group("cars"):
		body_in7 +=1

func _on_dead_line_7_body_exited(body):
	if body.is_in_group("cars"):
		body_in7 -=1

func _on_dead_line_8_body_entered(body):
	if body.is_in_group("cars"):
		body_in8 +=1

func _on_dead_line_8_body_exited(body):
	if body.is_in_group("cars"):
		body_in8 -=1

func _on_bus_rotate_body_entered(body):
	var timer1 = get_tree().create_timer(0.5)
	if body.is_in_group("bus"):
		await timer1.timeout
		object.rotate(1.57)
		object.direction = 2
		var timer2 = get_tree().create_timer(0.45)
		await timer2.timeout
		object.rotate(-1.57)
		object.direction = 3
		var stilltime_bus = int(timer.get_time_left())
		if stilltime_bus < 1:
			Global.count_crash += 1
			timeout_bus = true
		else: timeout_bus = false
		var timer3 = get_tree().create_timer(0.5)
		await timer3.timeout
		Global.stopbus = true

		var timer4 = get_tree().create_timer(4)
		await timer4.timeout
		object.queue_free()
		bus_out = false
		Global.stopbus = false
		timer = get_tree().create_timer(45)
		
		
		
		
		



	




func _on_pause_pressed():
	get_tree().paused = !get_tree().paused
