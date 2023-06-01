extends Control
var player;


@export var player_max_cans_cost : int = 10;
@export var player_trash_capacity_cost : int = 10;
@export var trash_can_can_capacity_cost : int = 10;
@export var city_health_restore_cost : int = 10;
@export var enemy_spawn_decrease_cost : int = 10;



#Use this variable to call functions that (should) change the player variables as well
# Ex: Instead of player.set_max_cans(5)    do

# GlobalPlayerVariables.set_max_cans(5);
# player.update_values()     <--- Not entirely necessary but I think it should be included as it changes the values in the shop. The values will
# Get updated upon returning to the night scene but I do not want to rely on that as that may introduce bugs

# Calling update_values on a PLAYER INSTANCE will load all values from the global storage into the local instance
func _ready():
	player = get_node("../PlayerCat");
	
	#Give player $80 for the day
	GlobalPlayerVariables.add_money(GlobalPlayerVariables.daily_player_income);
	get_parent().get_node("Camera2D/UI_Money").set_text(str(GlobalPlayerVariables.get_money()))
	

func _on_playercanupgrade_pressed():
	if(GlobalPlayerVariables.get_money() >= player_max_cans_cost):
		subtract_money(player_max_cans_cost);
		
		var cur = GlobalPlayerVariables.get_max_cans()
		cur += 1
		GlobalPlayerVariables.set_max_cans(cur)
		player.update_values()
		print("------------Can Upgrade------------")
		print("Global: ", GlobalPlayerVariables.max_available_cans);
		print("Local: ", player.max_available_cans);



func _on_playerheldupgrade_pressed():
	if(GlobalPlayerVariables.get_money() >= player_trash_capacity_cost):
		subtract_money(player_trash_capacity_cost);
		GlobalPlayerVariables.set_max_capacity(GlobalPlayerVariables.get_max_capacity() + 1);
		player.update_values();
		print("------------Player Capacity Upgrade------------")
		print("Global: ", GlobalPlayerVariables.get_max_capacity());
		print("Local: ", player.get_max_capacity());
		print("$", GlobalPlayerVariables.get_money())
	# Replace with function body.

func _on_trashcanupgrade_pressed():
	#trashcan capacity increased
	if(GlobalPlayerVariables.get_money() >= trash_can_can_capacity_cost):
		subtract_money(trash_can_can_capacity_cost);
		GlobalPlayerVariables.set_trash_can_capacity(GlobalPlayerVariables.get_trash_can_capacity() + 1)
		print("------------Can Capacity Upgrade------------")
		print("Global: ", GlobalPlayerVariables.get_trash_can_capacity());
	
func _on_restore_pressed():
	if(GlobalPlayerVariables.get_money() >= city_health_restore_cost):
		subtract_money(city_health_restore_cost);
		GlobalPlayerVariables.set_city_happiness(GlobalPlayerVariables.get_city_max_happiness());
	
	

func _on_back_to_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")


func subtract_money(val):
	GlobalPlayerVariables.subtract_money(val);
	get_parent().get_node("Camera2D/UI_Money").set_text(str(GlobalPlayerVariables.get_money()))


func _on_decrease_pressed():
	if(GlobalPlayerVariables.get_money() >= enemy_spawn_decrease_cost):
		EnemySpawner.shopcorrector += 1
		print('checkafterincrease', EnemySpawner.shopcorrector)
		subtract_money(enemy_spawn_decrease_cost);
		print(EnemySpawner.difficulty)
		EnemySpawner.increase_difficulty(-0.5)
	
