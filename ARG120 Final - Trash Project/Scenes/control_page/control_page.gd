extends Control


func _on_onclick_pressed():
	GlobalPlayerVariables.RESET_TO_DEFAULT_VALUES();
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")
	print(get_tree().current_scene);
