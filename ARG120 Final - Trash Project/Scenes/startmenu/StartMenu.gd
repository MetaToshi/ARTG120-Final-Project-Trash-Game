extends Control

func _ready():
	pass
	
	

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")



func _on_options_button_pressed():
	pass # Replace with function body.



func _on_quit_button_pressed():
	get_tree().quit()
