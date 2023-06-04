extends Control
var player;



#         var can_amount_cost 
#@onready var player_capacity_cost 
#@onready var can_capacity_cost
#@onready var city_restore_cost
#@onready var enemy_decrease_cost 


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
	
	update_bar();
	
	
	

func _on_playercanupgrade_pressed():
	if(GlobalPlayerVariables.get_money() >= GlobalPlayerVariables.can_amount_cost):
		
		subtract_money(GlobalPlayerVariables.can_amount_cost);
		
		var cur = GlobalPlayerVariables.get_max_cans()
		cur += 1
		GlobalPlayerVariables.set_max_cans(cur)
		player.update_values()
		print("------------Can Upgrade------------")
		print("Global: ", GlobalPlayerVariables.max_available_cans);
		print("Local: ", player.max_available_cans);
		
		#update shop cost
		GlobalPlayerVariables.can_amount_cost += 10;
		#update the tooltip
		($MarginContainer/VBoxContainer/playercanupgrade).tooltip_text = "Increase Max Number of Trashcans Held by Player
		Costs: "+ str(GlobalPlayerVariables.can_amount_cost) + " Dollars"
		
		($MarginContainer/VBoxContainer/playercanupgrade).text = "Increase Player Garbage Can Capacity    $" + str(GlobalPlayerVariables.can_amount_cost);



func _on_playerheldupgrade_pressed():
	if(GlobalPlayerVariables.get_money() >= GlobalPlayerVariables.player_capacity_cost):
		subtract_money(GlobalPlayerVariables.player_capacity_cost);
		GlobalPlayerVariables.set_max_capacity(GlobalPlayerVariables.get_max_capacity() + 1);
		player.update_values();
		print("------------Player Capacity Upgrade------------")
		print("Global: ", GlobalPlayerVariables.get_max_capacity());
		print("Local: ", player.get_max_capacity());
		print("$", GlobalPlayerVariables.get_money())
		
		#update price
		GlobalPlayerVariables.player_capacity_cost += 10;
		#
		($MarginContainer/VBoxContainer/playerheldupgrade).tooltip_text = "Increases how much garbage the player can hold.
		Costs: "+ str(GlobalPlayerVariables.player_capacity_cost) + " Dollars"
		
		($MarginContainer/VBoxContainer/playerheldupgrade).text = "Increase Player Held Garbage Capacity   $" + str(GlobalPlayerVariables.player_capacity_cost);
	

func _on_trashcanupgrade_pressed():
	#trashcan capacity increased
	if(GlobalPlayerVariables.get_money() >= GlobalPlayerVariables.can_capacity_cost):
		subtract_money(GlobalPlayerVariables.can_capacity_cost);
		GlobalPlayerVariables.set_trash_can_capacity(GlobalPlayerVariables.get_trash_can_capacity() + 1)
		print("------------Can Capacity Upgrade------------")
		print("Global: ", GlobalPlayerVariables.get_trash_can_capacity());
		
		GlobalPlayerVariables.can_capacity_cost += 10;
		($MarginContainer/VBoxContainer/trashcanupgrade).tooltip_text = "Increases the amount of trash the Trashcans can hold.
		Costs: "+ str(GlobalPlayerVariables.can_capacity_cost) + " Dollars"
		
		($MarginContainer/VBoxContainer/trashcanupgrade).text = "Increase Garbage Can Held Garbage Capacity  $" + str(GlobalPlayerVariables.can_capacity_cost);
	
func _on_restore_pressed():
	if(GlobalPlayerVariables.get_money() >= GlobalPlayerVariables.city_restore_cost):
		subtract_money(GlobalPlayerVariables.city_restore_cost);
		GlobalPlayerVariables.set_city_happiness(GlobalPlayerVariables.get_city_max_happiness());
		GlobalPlayerVariables.city_restore_cost += 10;
		
		update_bar()
		
		($MarginContainer/VBoxContainer/Restore).tooltip_text = "Restores Cleanliness to the City
		Costs: "+ str(GlobalPlayerVariables.city_restore_cost) + " Dollars"
		
		($MarginContainer/VBoxContainer/Restore).text = "Restore City Cleanliness               $" + str(GlobalPlayerVariables.city_restore_cost);
	
	
func _on_decrease_pressed():
	if EnemySpawner.shopcorrector < 0.3:
		if(GlobalPlayerVariables.get_money() >= GlobalPlayerVariables.enemy_decrease_cost):
			subtract_money(GlobalPlayerVariables.enemy_decrease_cost);
			EnemySpawner.increase_difficulty(-0.1)
			EnemySpawner.shopcorrector += 0.1
			GlobalPlayerVariables.enemy_decrease_cost += 10;
			($MarginContainer/VBoxContainer/decrease).tooltip_text = "Slightly decrease enemy spawn during the next night.
			Costs: "+ str(GlobalPlayerVariables.enemy_decrease_cost) + " Dollars"
			($MarginContainer/VBoxContainer/decrease).text = "Decrease Enemy Spawn                 $" + str(GlobalPlayerVariables.enemy_decrease_cost);
			
			if (EnemySpawner.shopcorrector >= 0.3):
				($MarginContainer/VBoxContainer/decrease).text = "Sold out!"
	else:
		($MarginContainer/VBoxContainer/decrease).text = "Sold out!"
		print('You already purchased this 3 times!')

func _on_back_to_level_pressed():
	GlobalPlayerVariables.night_num += 1;
	get_tree().change_scene_to_file("res://Scenes/night_scene/night.tscn")


func subtract_money(val):
	GlobalPlayerVariables.subtract_money(val);
	get_parent().get_node("Camera2D/UI_Money").set_text(str(GlobalPlayerVariables.get_money()))
	

func update_bar():
	get_parent().get_node("Camera2D/Town Health Bar").set_max_health(GlobalPlayerVariables.current_max_happiness);
	get_parent().get_node("Camera2D/Town Health Bar").set_current_value(GlobalPlayerVariables.current_happiness);
