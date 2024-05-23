extends Node2D


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
	
	


func _on_rules_pressed():
	get_tree().change_scene_to_file("res://scenes/rules.tscn")




func _on_level_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
