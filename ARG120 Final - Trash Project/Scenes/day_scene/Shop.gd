extends Control
var player;

func _ready():
	player = get_node("../PlayerCat")

func _on_playercanupgrade_pressed():
	var cur = player.get_max_cans()
	cur += 1
	player.set_max_cans(cur)



func _on_playerheldupgrade_pressed():
	pass # Replace with function body.




func _on_back_to_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")
