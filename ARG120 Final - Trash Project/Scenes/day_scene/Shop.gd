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
	print("------------Can Upgrade------------")
	print("Global: ", GlobalPlayerVariables.max_available_cans);
	print("Local: ", player.max_available_cans);



func _on_playerheldupgrade_pressed():
	
	GlobalPlayerVariables.set_max_capacity(GlobalPlayerVariables.get_max_capacity() + 1);
	player.update_values();
	print("------------Player Capacity Upgrade------------")
	print("Global: ", GlobalPlayerVariables.get_max_capacity());
	print("Local: ", player.get_max_capacity());
	# Replace with function body.

func _on_trashcanupgrade_pressed():
	#trashcan capacity increased
	GlobalPlayerVariables.set_trash_can_capacity(GlobalPlayerVariables.get_trash_can_capacity() + 1)
	print("------------Can Capacity Upgrade------------")
	print("Global: ", GlobalPlayerVariables.get_trash_can_capacity());
	
func _on_restore_pressed():
	GlobalPlayerVariables.set_city_happiness(GlobalPlayerVariables.get_city_max_happiness());
	
	

func _on_back_to_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")


