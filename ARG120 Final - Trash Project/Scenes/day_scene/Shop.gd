extends Control
var player;

#Use this variable to call functions that (should) change the player variables as well
# Ex: Instead of player.set_max_cans(5)    do

# GlobalPlayerVariables.set_max_cans(5);
# player.update_values()     <--- Not entirely necessary but I think it should be included as it changes the values in the shop. The values will
# Get updated upon returning to the night scene but I do not want to rely on that as that may introduce bugs

# Calling update_values on a PLAYER INSTANCE will load all values from the global storage into the local instance

func _ready():
	player = get_node("../PlayerCat");

func _on_playercanupgrade_pressed():
	var cur = GlobalPlayerVariables.get_max_cans()
	cur += 1
	GlobalPlayerVariables.set_max_cans(cur)
	player.update_values()
	print("Global: ", GlobalPlayerVariables.max_available_cans);
	print("Local: ", player.max_available_cans);



func _on_playerheldupgrade_pressed():
	pass # Replace with function body.




func _on_back_to_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")
