extends Control



func _on_onclick_pressed():
		get_tree().change_scene_to_file("res://Scenes/startmenu/StartMenu.tscn")
		


func _on_timer_timeout():
		get_tree().change_scene_to_file("res://Scenes/startmenu/StartMenu.tscn")
