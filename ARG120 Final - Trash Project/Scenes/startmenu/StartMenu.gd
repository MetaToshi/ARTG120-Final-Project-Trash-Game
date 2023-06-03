extends Control

func _ready():
	pass
	
	

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/control_page/control_page.tscn")



func _on_options_button_pressed():
	pass # Replace with function body.



func _on_quit_button_pressed():
	get_tree().quit()
