extends Control



func _on_onclick_pressed():
		GlobalPlayerVariables.RESET_TO_DEFAULT_VALUES
		get_tree().change_scene_to_file("res://Scenes/startmenu/StartMenu.tscn")


func _on_timer_timeout():
		GlobalPlayerVariables.RESET_TO_DEFAULT_VALUES
		get_tree().change_scene_to_file("res://Scenes/startmenu/StartMenu.tscn")
